FROM ubuntu:trusty
MAINTAINER Oleksii Aliakin <alex@nls.la>

ENV DEBIAN_FRONTEND noninteractive

# Add ubuntu-sdk repo and install qt5
RUN apt-get update                                 \
 && apt-get install -y software-properties-common  \
 && add-apt-repository ppa:ubuntu-sdk-team/ppa     \
 && apt-get update                                 \
 && apt-get install --no-install-recommends -y     \
        autoconf \
        automake \
        g++ \
        gcc \
        git \
        libqt5qml-graphicaleffects \
        libqt5qml-quickcontrols    \
        libqt5qml5                 \
        libqt5svg5-dev             \
        make                       \
        python                     \
        qt5-default                \
        qtdeclarative5-controls-plugin     \
        qtdeclarative5-dev                 \
        qtdeclarative5-dialogs-plugin      \
        qtdeclarative5-qtquick2-plugin     \
        qtdeclarative5-quicklayouts-plugin \
        qtdeclarative5-settings-plugin     \
        qtscript5-dev                      \
 && apt-get clean

# build latest qbs and patchelf
RUN cd /tmp                                    \
 && git clone git://code.qt.io/qt-labs/qbs.git \
 && qmake -r qbs/qbs.pro                       \
 && make -j4                                   \
 && make install                               \
                                               \
 && cd /tmp                                    \
 && git clone https://github.com/NixOS/patchelf.git patchelf \
 && cd patchelf && ./bootstrap.sh && ./configure             \
 && make && make install                                     \
 && cd /tmp && find . -delete                                \
 && apt-get -y purge autoconf automake
