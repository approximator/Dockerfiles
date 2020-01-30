FROM ubuntu:bionic

RUN apt-get update && apt-get install -y software-properties-common sudo       \
      gcc-7 g++-7 gcc-8 g++-8                                                  \
      build-essential perl python python3 python3-pip git make cmake           \
      libfontconfig1-dev libxcb1-dev libx11-dev libc6-dev libgl1-mesa-dev      \
      '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev \
      xcb-proto

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt-get update && apt-get -y build-dep qt5-default

RUN pip3 install conan

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
