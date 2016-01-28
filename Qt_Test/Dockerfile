FROM ubuntu:wily
MAINTAINER Oleksii Aliakin <alex@nls.la>

ENV DEBIAN_FRONTEND noninteractive

# install all the libraries needed for running qt application
RUN apt-get update \
 && apt-get install --no-install-recommends -y    \
        "^libxcb.*"             \
        imagemagick             \
        libdbus-1-3             \
        libdouble-conversion1v5 \
        libegl1-mesa            \
        libfontconfig1          \
        libgl1-mesa-glx         \
        libharfbuzz0b           \
        libmtdev1               \
        libpng12-0              \
        libsm6                  \
        libstdc++6              \
        libx11-6                \
        libx11-xcb1             \
        libxcb-render0          \
        libxi6                  \
        libxkbcommon-x11-0      \
        libxkbcommon0           \
        libxrender1             \
        xvfb                    \
 && apt-get clean

ADD take_screenshot.sh /
