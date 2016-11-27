#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
    ca-certificates \
    wget

gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4

arch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"
cd /usr/local/bin
wget -O gosu "https://github.com/tianon/gosu/releases/download/1.10/gosu-$arch"
wget -O gosu.asc "https://github.com/tianon/gosu/releases/download/1.10/gosu-$arch.asc"
gpg --verify gosu.asc
rm gosu.asc
chmod +x gosu
# ./gosu
