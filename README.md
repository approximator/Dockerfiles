# Dockerfiles

[![Build Status](https://travis-ci.org/approximator/Dockerfiles.svg?branch=master)](https://travis-ci.org/approximator/Dockerfiles)

## qt

[![](https://images.microbadger.com/badges/image/approximator/qt.svg)](https://hub.docker.com/r/approximator/qt/)
[![](https://images.microbadger.com/badges/version/approximator/qt.svg)](https://hub.docker.com/r/approximator/qt/tags/)
[![](https://images.microbadger.com/badges/commit/approximator/qt.svg)](http://microbadger.com/images/approximator/qt)

Currently there are two versions of Qt: **5.6.1** and **5.7.0** that can be pulled
as: `docker pull approximator/qt:5.6.1` and `docker pull approximator/qt:5.7.0`

## qbs

[![](https://images.microbadger.com/badges/image/approximator/qbs.svg)](https://hub.docker.com/r/approximator/qbs/)
[![](https://images.microbadger.com/badges/version/approximator/qbs.svg)](https://hub.docker.com/r/approximator/qbs/tags/)
[![](https://images.microbadger.com/badges/commit/approximator/qbs.svg)](http://microbadger.com/images/approximator/qbs)

Several versions of **qbs** with different versions of Qt.

## qtcreator

[![](https://images.microbadger.com/badges/image/approximator/qtcreator.svg)](https://hub.docker.com/r/approximator/qtcreator/)
[![](https://images.microbadger.com/badges/version/approximator/qtcreator.svg)](https://hub.docker.com/r/approximator/qbs/qtcreator/)
[![](https://images.microbadger.com/badges/commit/approximator/qtcreator.svg)](http://microbadger.com/images/approximator/qtcreator)

Several version of **QtCreator** based on **qt:5.6.1** and **qt:5.7.0** images.
Use `qtcreator/qtcreator` script to start **qtcreator** inside the docker.

Note: current `$PWD` will be mounted to the container.

## cppcheck

[![](https://images.microbadger.com/badges/image/approximator/cppcheck.svg)](https://hub.docker.com/r/approximator/cppcheck/)
[![](https://images.microbadger.com/badges/version/approximator/cppcheck.svg)](https://hub.docker.com/r/approximator/cppcheck/tags/)
[![](https://images.microbadger.com/badges/commit/approximator/cppcheck.svg)](http://microbadger.com/images/approximator/cppcheck)

## qttest

[![](https://images.microbadger.com/badges/image/approximator/qttest.svg)](https://hub.docker.com/r/approximator/qttest/)
[![](https://images.microbadger.com/badges/version/approximator/qttest.svg)](https://hub.docker.com/r/approximator/qttest/tags/)
[![](https://images.microbadger.com/badges/commit/approximator/qttest.svg)](http://microbadger.com/images/approximator/qttest)

Clean ubuntu with **X11** libs installed to allow Qt applications running.

See an example of screenshot taking using this image:
https://github.com/approximator/FlightGear_Autopilot/blob/devel/.travis.yml

## Pycharm

[![](https://images.microbadger.com/badges/image/approximator/pycharm.svg)](https://hub.docker.com/r/approximator/pycharm/)
[![](https://images.microbadger.com/badges/version/approximator/pycharm.svg)](https://hub.docker.com/r/approximator/pycharm/tags/)
[![](https://images.microbadger.com/badges/commit/approximator/pycharm.svg)](http://microbadger.com/images/approximator/pycharm)

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
