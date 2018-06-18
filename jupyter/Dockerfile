FROM ubuntu:bionic

RUN echo "deb http://archive.ubuntu.com/ubuntu bionic multiverse" | tee -a /etc/apt/sources.list \
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
                                   \
 && pip3 install -U setuptools wheel \
 && pip3 install -U numpy jupyter    \
 && apt-get clean                    \
                                     \
 && cd /tmp/               && find . -delete \
 && cd /var/lib/apt/lists/ && find . -delete \
 && cd /var/tmp/           && find . -delete

EXPOSE 8888

ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer=alex@nls.la                                                   \
      org.label-schema.build-date=$BUILD_DATE                                  \
      org.label-schema.vcs-ref=$VCS_REF                                        \
      org.label-schema.vcs-type="git"                                          \
      org.label-schema.vcs-url="https://github.com/approximator/Dockerfiles"
