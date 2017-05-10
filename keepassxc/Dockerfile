FROM ubuntu:xenial

ADD common/entrypoint.sh /usr/local/bin/entrypoint.sh
ADD common/setup.sh /tmp/setup.sh

ENV CMAKE_PREFIX_PATH=/opt/qt58/lib/cmake \
    LD_LIBRARY_PATH=/opt/qt58/lib

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

RUN deps='                   \
          g++                \
          gcc                \
          make               \
          automake           \
          git                \
          cmake              \
          libgcrypt20-dev    \
          qt58base           \
          qt58tools          \
          qt58x11extras      \
          libxi-dev          \
          libxtst-dev        \
          zlib1g-dev         \
          libyubikey-dev     \
          libykpers-1-dev    \
          xvfb               \
          wget               \
          file               \
          fuse               \
          python             \
          mesa-common-dev    \
          libqt5widgets5     \
          libmicrohttpd10    \
          libgcrypt20        \
	      '                    \
 && /tmp/setup.sh            \
                             \
 && apt-get update           \
 && apt-get install --no-install-recommends -y software-properties-common       \
 && add-apt-repository --yes ppa:beineri/opt-qt58-xenial                        \
 && apt-get update                                                              \
 && apt-get install --no-install-recommends -y $deps                            \
 && apt-get clean                                                               \
                                                                                \
 && set -x && echo /opt/qt58/lib > /etc/ld.so.conf.d/qt58.conf                  \
 && git clone -b 2.1.4 https://github.com/keepassxreboot/keepassxc.git /tmp/keepassxc \
                                                                                \
 && cd /tmp/keepassxc                                                           \
 && mkdir build && cd build                                                     \
 && cmake -DWITH_TESTS=OFF -DWITH_XC_AUTOTYPE=ON -DWITH_XC_HTTP=ON ..           \
 && make -j5                                                                    \
 && make install                                                                \
 && cd /tmp/               && find . -delete                                    \
 && cd /var/lib/apt/lists/ && find . -delete                                    \
 && cd /var/tmp/           && find . -delete

ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer=alex@nls.la                                                   \
      org.label-schema.build-date=$BUILD_DATE                                  \
      org.label-schema.vcs-ref=$VCS_REF                                        \
      org.label-schema.vcs-type="git"                                          \
      org.label-schema.vcs-url="https://github.com/approximator/Dockerfiles"
