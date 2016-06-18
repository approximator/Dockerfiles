FROM ubuntu:wily
MAINTAINER alex@nls.la

RUN echo "deb http://archive.ubuntu.com/ubuntu wily multiverse" | tee -a /etc/apt/sources.list \
 && DEBIAN_FRONTEND=noninteractive apt update                             \
 && DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -y \
        biber                      \
        build-essential            \
        gfortran                   \
        latexmk                    \
        libatlas-base-dev          \
        libblas-dev                \
        libfreetype6-dev           \
        liblapack-dev              \
        lmodern                    \
        make                       \
        pandoc                     \
        python3                    \
        python3-dev                \
        python3-matplotlib         \
        python3-mpmath             \
        python3-pip                \
        python3-scipy              \
        python3-sympy              \
        texlive-fonts-extra        \
        texlive-fonts-recommended  \
        texlive-generic-extra      \
        texlive-lang-cyrillic      \
        texlive-latex-extra        \
        texlive-latex-recommended  \
        texlive-publishers         \
        texlive-xetex              \
 && pip3 install -U pip            \
 && pip3 install -U numpy jupyter  \
 && apt-get clean                  \
 && rm -rf /var/lib/apt/lists/
