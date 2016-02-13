FROM ubuntu:wily
MAINTAINER Oleksii Aliakin <alex@nls.la>

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

RUN echo "deb http://archive.ubuntu.com/ubuntu wily multiverse" | tee -a /etc/apt/sources.list \
 && DEBIAN_FRONTEND=noninteractive apt-get update                             \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        biber                      \
        latexmk                    \
        lmodern                    \
        make                       \
        msttcorefonts              \
        pandoc                     \
        texlive-full               \
 && apt-get clean
