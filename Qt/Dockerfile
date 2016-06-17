FROM ubuntu:16.04
MAINTAINER alex@nls.la

RUN DEBIAN_FRONTEND=noninteractive apt update \
 && DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -y \
    "^libxcb.*"                            \
    autoconf                               \
    automake                               \
    bison                                  \
    cmake                                  \
    flex                                   \
    g++                                    \
    git                                    \
    gperf                                  \
    libasound2-dev                         \
    libcap-dev                             \
    libdbus-1-dev                          \
    libegl1-mesa-dev                       \
    libfontconfig1-dev                     \
    libfreetype6-dev                       \
    libglu1-mesa-dev                       \
    libgstreamer-plugins-base0.10-dev      \
    libgstreamer0.10-dev                   \
    libicu-dev                             \
    libnss3-dev                            \
    libpci-dev                             \
    libpulse-dev                           \
    libssl-dev                             \
    libudev-dev                            \
    libx11-dev                             \
    libx11-xcb-dev                         \
    libxcomposite-dev                      \
    libxcursor-dev                         \
    libxdamage-dev                         \
    libxext-dev                            \
    libxfixes-dev                          \
    libxi-dev                              \
    libxrandr-dev                          \
    libxrender-dev                         \
    libxslt-dev                            \
    libxss-dev                             \
    libxtst-dev                            \
    perl                                   \
    python                                 \
    ruby                                   \
    wget

ENV QTDIR="/usr/local/Qt56"                       \
    LD_LIBRARY_PATH=/usr/local/Qt56/lib           \
    PKG_CONFIG_PATH=/usr/local/Qt56/lib/pkgconfig \
    PATH=/usr/local/Qt56/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

RUN cd /tmp                                                                    \
 && git clone git://code.qt.io/qt-labs/qbs.git                                 \
 && git clone https://github.com/NixOS/patchelf.git patchelf                   \
 && wget -c http://download.qt.io/official_releases/qt/5.6/5.6.1/single/qt-everywhere-opensource-src-5.6.1.tar.gz \
                                                                               \
 && mkdir /tmp/qt-build && cd /tmp/qt-build                                    \
 && tar xvf /tmp/qt-everywhere-opensource-src-5.6.1.tar.gz                     \
 && cd /tmp/qt-build/qt-everywhere-opensource-src-5.6.1                        \
                                                                               \
 && ./configure -prefix "/usr/local/Qt56" -confirm-license -opensource -release\
                -dbus-linked -openssl-linked -qt-zlib -qt-libjpeg -qt-libpng   \
                -qt-xcb -qt-xkbcommon -qt-xkbcommon-x11 -qt-freetype -qt-pcre  \
                -qt-harfbuzz -no-nis -icu -nomake examples                     \
 && make -j5                                                                   \
 && make install                                                               \
                                                                               \
 && cd /tmp                                                                    \
 && qmake -r qbs/qbs.pro                                                       \
 && make -j5                                                                   \
 && make install                                                               \
                                                                               \
 && cd /tmp                                                                    \
 && cd patchelf && ./bootstrap.sh && ./configure                               \
 && make -j5 && make install                                                   \
 && cd /tmp && find . -delete
