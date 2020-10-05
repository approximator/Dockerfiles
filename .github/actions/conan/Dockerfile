FROM ubuntu:focal

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list                    \
 && apt-get update                                                             \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y                          \
      software-properties-common sudo gcc-9 g++-9                              \
      build-essential perl python python3 python3-pip git make cmake           \
      libfontconfig1-dev libxcb1-dev libx11-dev libc6-dev libgl1-mesa-dev      \
      '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev \
      xcb-proto xorg-dev wget fuse                                             \
 && apt-get -y build-dep qt5-default

RUN pip3 install conan

RUN git clone https://github.com/conan-io/conan.git \
 && cd conan  \
 && pip3 install -r conans/requirements.txt  \
 && pip3 install -r conans/requirements_server.txt  \
 && pip3 install gunicorn \
 && conan --help

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
