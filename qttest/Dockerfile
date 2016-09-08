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
 && pip install pyscreenshot pyvirtualdisplay easyprocess -V \
                                                             \
 && cd /tmp/               && find . -delete                 \
 && cd /var/lib/apt/lists/ && find . -delete                 \
 && cd /var/tmp/           && find . -delete

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE                                  \
      org.label-schema.vcs-ref=$VCS_REF                                        \
      org.label-schema.vcs-type="git"                                          \
      org.label-schema.vcs-url="https://github.com/approximator/Dockerfiles"
