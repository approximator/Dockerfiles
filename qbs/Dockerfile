FROM approximator/qt
MAINTAINER alex@nls.la

RUN cd /tmp                                                                    \
 && git clone -b 1.5 git://code.qt.io/qt-labs/qbs.git                          \
 && git clone https://github.com/NixOS/patchelf.git patchelf                   \
 && qmake -r qbs/qbs.pro                                                       \
 && make -j5                                                                   \
 && make install                                                               \
                                                                               \
 && cd /tmp                                                                    \
 && cd patchelf && ./bootstrap.sh && ./configure                               \
 && make -j5 && make install                                                   \
 && cd /tmp && find . -delete
