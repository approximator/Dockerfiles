FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

# install all the libraries needed for running qt application
# and python scripts
RUN apt-get update \
 && apt-get install --no-install-recommends -y    \
        "^libxcb.*"             \
        gir1.2-gtk-2.0          \
        imagemagick             \
        libdbus-1-3             \
        libdouble-conversion3   \
        libegl1-mesa            \
        libfontconfig1          \
        libgl1-mesa-glx         \
        libharfbuzz0b           \
        libmtdev1               \
        libpng16-16             \
        libsm6                  \
        libstdc++6              \
        libx11-6                \
        libx11-xcb1             \
        libxcb-render0          \
        libxi6                  \
        libxkbcommon-x11-0      \
        libxkbcommon0           \
        libxrender1             \
        python3-matplotlib      \
        python3-pillow          \
        python3-pip             \
        python3-wxgtk4.0        \
        wx3.0-i18n              \
        xvfb                    \
 && apt-get clean               \
 && python3 -m pip install -U   \
     pip                        \
     wheel                      \
     setuptools                 \
 && python3 -m pip install      \
     pyscreenshot               \
     pyvirtualdisplay           \
     easyprocess                \
                                \
 && cd /tmp/               && find . -delete \
 && cd /var/lib/apt/lists/ && find . -delete \
 && cd /var/tmp/           && find . -delete

ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer=alex@nls.la                                 \
      org.label-schema.build-date=$BUILD_DATE                \
      org.label-schema.vcs-ref=$VCS_REF                      \
      org.label-schema.vcs-type="git"                        \
      org.label-schema.vcs-url="https://github.com/approximator/Dockerfiles"
