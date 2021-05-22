#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
    ca-certificates \
    gosu            \
    gpg             \
    libssl-dev      \
    libuv1-dev      \
    locales         \
    sudo            \
    tzdata          \
    wget

ln -fs /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

locale-gen en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
