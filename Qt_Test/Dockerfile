FROM ubuntu:wily
MAINTAINER alex@nls.la

ENV DEBIAN_FRONTEND noninteractive

# install all the libraries needed for running qt application
# and python scripts
RUN apt-get update \
 && apt-get install --no-install-recommends -y    \
        "^libxcb.*"             \
        gir1.2-gtk-2.0          \
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
        python-matplotlib       \
        python-pillow           \
        python-pip              \
        python-wxgtk2.8         \
        python-wxtools          \
        wx2.8-i18n              \
        xvfb                    \
 && apt-get clean               \
 && rm -rf /var/lib/apt/lists/  \
 && pip install pyscreenshot pyvirtualdisplay easyprocess -V

ADD take_screenshot.sh /
