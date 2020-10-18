import os
import shutil
import logging
import requests

from pathlib import Path

from git import Repo, Actor
from github import Github
from semver import VersionInfo
from markdownify import markdownify

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s.%(msecs)-3d %(levelname)-8s [%(filename)s:%(lineno)d] %(message)s",
    datefmt="%d-%m-%Y:%H:%M:%S",
)
logger = logging.getLogger("DockerfilesUpdater")

THIS_DIR: Path = Path(__file__).resolve().parent


def parse_version(version: str) -> VersionInfo:
    components = version.split(".")

    for _ in range(0, 3 - len(components)):
        components.append("0")

    components = [
        "".join([c for c in component if c.isdigit()]) for component in components
    ]

    return VersionInfo(*components)


def get_releases(releases_info_url):
    data = requests.get(releases_info_url)

    releases = [
        dict(
            version=parse_version(release["version"]),
            date=release["date"],
            link=release["downloads"].get("linux", dict(link=""))["link"],
            whatsnew=release["whatsnew"],
        )
        for release in data.json()[0].get("releases", [])
        if release["type"] == "release"
    ]
    return releases


def get_current_images(dockerfiles_dir):
    current_images = [
        dict(
            version=VersionInfo.parse(str(filename).split("_")[-1]),
            filename=filename,
        )
        for filename in dockerfiles_dir.glob("Dockerfile_*")
    ]
    return current_images


def branch_exists(repo, branch_name) -> bool:
    for ref in repo.remotes.origin.refs:
        if str(ref).endswith(branch_name):
            return True

    return False


def main():
    config = [
        dict(
            releases_info_url="https://data.services.jetbrains.com/products?code=PCC",
            dockerfile_dir=THIS_DIR.parent / "pycharm",
            download_url_template="DOWNLOAD_URL=https://download.jetbrains.com/python/pycharm-community-{version}.tar.gz",
        ),
        dict(
            releases_info_url="https://data.services.jetbrains.com/products?code=CL",
            dockerfile_dir=THIS_DIR.parent / "clion",
            download_url_template="DOWNLOAD_URL=https://download.jetbrains.com/cpp/CLion-{version}.tar.gz",
        ),
    ]

    for conf in config:
        releases_info_url = conf["releases_info_url"]
        download_url_template = conf["download_url_template"]
        dockerfile_dir = conf["dockerfile_dir"]

        releases = get_releases(releases_info_url)
        current_images = get_current_images(dockerfile_dir)

        newest_release = sorted(releases, key=lambda rel: rel["version"], reverse=True)[
            0
        ]
        current_file = sorted(
            current_images, key=lambda rel: rel["version"], reverse=True
        )[0]

        logger.info(f"Newest release {newest_release}")
        logger.info(f"Current file: {current_file}")

        if current_file["version"] >= newest_release["version"]:
            logger.info("Up to date. Nothing to do.")
            continue

        logger.info("Newer version available. Updating...")

        old_version: str = str(current_file["version"])
        new_version: str = str(newest_release["version"])

        new_branch_name = f"update/{dockerfile_dir.name}-{new_version}"
        shutil.rmtree("/tmp/image_updater", ignore_errors=True)

        repo = Repo.clone_from(os.environ.get("REPO_URL"), "/tmp/image_updater")
        repo_path = Path(repo.working_tree_dir)
        logger.debug(f"Repo path: {repo_path}")

        if branch_exists(repo, new_branch_name):
            logger.warning(f"Branch {new_branch_name} alredy exists... Do nothing.")
            continue

        repo.head.reference = repo.create_head(new_branch_name)

        old_name: Path = repo_path / dockerfile_dir.name / f"Dockerfile_{old_version}"
        new_name: Path = repo_path / dockerfile_dir.name / f"Dockerfile_{new_version}"
        old_name.rename(new_name)

        logger.debug(download_url_template.format(version=old_version))
        logger.debug(download_url_template.format(version=new_version))

        content = (
            open(new_name, "r")
            .read()
            .replace(
                download_url_template.format(version=old_version),
                download_url_template.format(version=new_version),
            )
        )

        open(new_name, "w").write(content)
        dockerfile = repo_path / dockerfile_dir.name / "Dockerfile"
        dockerfile.unlink()
        dockerfile.symlink_to(f"Dockerfile_{new_version}")

        repo.index.remove(str(old_name))
        repo.index.add([str(dockerfile), str(new_name)])

        title = f"[{dockerfile_dir.name}] New version: {new_version}"
        body = f"{markdownify(newest_release['whatsnew'])}"

        repo.index.commit(
            f"{title}\n\n{body}",
            author=Actor("Approximator", "alex@nls.la"),
            committer=Actor("Approximator", "alex@nls.la"),
        )
        repo.remotes.origin.push(new_branch_name, force=True)

        gh = Github(os.environ.get("TOKEN"))
        gh.get_repo("approximator/Dockerfiles").create_pull(
            title=title, body=body, head=new_branch_name, base="master"
        )

    return 0


if __name__ == "__main__":
    exit(main())
