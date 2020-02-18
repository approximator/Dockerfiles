import glob
import logging
import requests

from pathlib import Path

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s.%(msecs)-3d %(levelname)-8s [%(filename)s:%(lineno)d] %(message)s",
    datefmt="%d-%m-%Y:%H:%M:%S",
)
logger = logging.getLogger("DockerfilesUpdater")

THIS_DIR: Path = Path(__file__).resolve().parent


data = requests.get("https://data.services.jetbrains.com/products?code=PCC")


def parse_version(version: str):
    return tuple(map(int, version.split(".")))


def version_to_str(version):
    return ".".join(map(str, version))


releases = [
    dict(
        version=parse_version(release["version"]),
        date=release["date"],
        link=release["downloads"].get("linux", dict(link=""))["link"],
    )
    for release in data.json()[0].get("releases", [])
    if release["type"] == "release"
]

current_images = [
    dict(version=parse_version(str(filename).split("_")[-1]), filename=filename)
    for filename in THIS_DIR.glob("Dockerfile_*")
]

newest_release = sorted(releases, key=lambda rel: rel["version"], reverse=True)[0]
current_file = sorted(current_images, key=lambda rel: rel["version"], reverse=True)[0]

logger.info(f"Newest release {newest_release}")
logger.info(f"Current file: {current_file}")

if current_file["version"] >= newest_release["version"]:
    logger.info("Up to date. Nothing to do.")
    open(THIS_DIR / "updated", "w").write("no")
    exit(0)

logger.info("Newer version available. Updating...")


old_version: str = version_to_str(current_file["version"])
new_version: str = version_to_str(newest_release["version"])
old_name: Path = THIS_DIR / f"Dockerfile_{old_version}"
new_name: Path = THIS_DIR / f"Dockerfile_{new_version}"
old_name.rename(new_name)

content = (
    open(new_name, "r")
    .read()
    .replace(
        f"DOWNLOAD_URL=https://download.jetbrains.com/python/pycharm-community-{old_version}.tar.gz",
        f"DOWNLOAD_URL=https://download.jetbrains.com/python/pycharm-community-{new_version}.tar.gz",
    )
)

open(new_name, "w").write(content)

Path(THIS_DIR / "Dockerfile").unlink()
Path(THIS_DIR / "Dockerfile").symlink_to(f"Dockerfile_{new_version}")

open(THIS_DIR / "updated", "w").write("yes")
open(THIS_DIR / "new_version", "w").write(new_version)
