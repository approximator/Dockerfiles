# Dockerfiles

## qt

Currently there are two versions of Qt: **5.6.1** and **5.7.0** can be pulled
as: `docker pull approximator/qt:5.6.1` and `docker pull approximator/qt:5.6.1`

## qbs

Several versions of **qbs** with different versions of Qt.

## qtcreator

Several version of **QtCreator** based on **qt:5.6.1** image.
Use `qtcreator/qtcreator` script to star **qtcreator** inside the docker.

Note: current `$PWD` will be mounted to the container.

## qttest

Clean ubuntu with **X11** libs installed to allow Qt applications running.

## Pycharm

To install additional pip packages, mounted `/home/$USER` directory
can be used.

Using pip:

- Go to terminal: `docker exec -ti <container_name> /bin/bash`
- become your host's user: `su <username>`
- install package to the user directory: `pip install --user <packages>`

Using pycharm:

- Navigate to `File -> Settings -> Project Interpreter` menu
- Press the `+` sign
- Check `Install to user's site packages directory`
- Finally search for and install necessary packages
