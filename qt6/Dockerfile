FROM ubuntu:20.04 as qtbuilder

ENV cmakever="3.19.4"

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list \
 && apt-get update                                          \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y       \
    build-essential             \
    clang                       \
    g++                         \
    gcc                         \
    git                         \
    libc6-dev                   \
    libclang-dev                \
    libfontconfig1-dev          \
    libfreetype6-dev            \
    libgl1-mesa-dev             \
    libglu1-mesa-dev            \
    libicu-dev                  \
    libx11-dev                  \
    libx11-xcb-dev              \
    libxcb-glx0-dev             \
    libxcb-icccm4-dev           \
    libxcb-image0-dev           \
    libxcb-keysyms1-dev         \
    libxcb-randr0-dev           \
    libxcb-render-util0-dev     \
    libxcb-shape0-dev           \
    libxcb-shm0-dev             \
    libxcb-sync-dev             \
    libxcb-util-dev             \
    libxcb-xfixes0-dev          \
    libxcb-xinerama0-dev        \
    libxcb-xkb-dev              \
    libxcb1-dev                 \
    libxext-dev                 \
    libxfixes-dev               \
    libxi-dev                   \
    libxkbcommon-dev            \
    libxkbcommon-x11-dev        \
    libxrender-dev              \
    make                        \
    ninja-build                 \
    perl                        \
    python3                     \
    python3-pip                 \
    software-properties-common  \
    wget                        \
    xcb-proto                   \
    xorg-dev

RUN wget -O /tmp/cmake.sh https://github.com/Kitware/CMake/releases/download/v${cmakever}/cmake-${cmakever}-Linux-x86_64.sh
RUN bash /tmp/cmake.sh --skip-license --prefix=/usr --exclude-subdir
