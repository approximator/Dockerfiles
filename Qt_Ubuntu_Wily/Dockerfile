FROM ubuntu:wily
MAINTAINER Oleksii Aliakin <alex@nls.la>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update                             \
 && apt-get install --no-install-recommends -y \
        g++            \
        gcc            \
        git            \
        libqt5svg5-dev \
        patchelf       \
        python         \
        qbs            \
        qml-module-qt-labs-settings   \
        qml-module-qtgraphicaleffects \
        qml-module-qtquick-controls   \
        qml-module-qtquick-dialogs    \
        qml-module-qtquick2           \
        qt5-default                   \
        qtdeclarative5-dev            \
 && apt-get clean
