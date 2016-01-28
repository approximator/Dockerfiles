FROM ubuntu:trusty
MAINTAINER Oleksii Aliakin <alex@nls.la>

ENV DEBIAN_FRONTEND noninteractive

# Add ubuntu-sdk repo and install qt5
RUN apt-get update                                 \
 && apt-get install -y software-properties-common  \
 && add-apt-repository ppa:ubuntu-sdk-team/ppa     \
 && apt-get update                                 \
 && apt-get install --no-install-recommends -y     \
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

# build latest qbs
RUN cd /tmp                                    \
 && git clone git://code.qt.io/qt-labs/qbs.git \
 && qmake -r qbs/qbs.pro \
 && make -j4             \
 && make install         \
 && rm -rf /tmp/*
