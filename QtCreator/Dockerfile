FROM approximator/qbs:1.5
MAINTAINER alex@nls.la

RUN cd /tmp                                                                    \
 && git clone --recursive https://code.qt.io/qt-creator/qt-creator.git         \
 && qmake -v                                                                   \
 && mkdir /tmp/qt-creator-build                                                \
 && cd qt-creator-build                                                        \
 && qmake -r ../qt-creator/qtcreator.pro                                       \
 && make -j5                                                                   \
 && make install INSTALL_ROOT=/usr                                             \
 && cd /tmp && find . -delete
