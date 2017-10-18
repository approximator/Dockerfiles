FROM base/archlinux

ADD common/entrypoint.sh /usr/local/bin/entrypoint.sh
ADD https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 /usr/local/bin/gosu

RUN yes | pacman --noconfirm -Syu    \
    libglvnd             \
    patchelf             \
    gcc                  \
    qt                   \
    qbs                  \
    python               \
 && chmod +x /usr/local/bin/gosu \
 && find /tmp/ -delete \
 && yes | pacman -Sc

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer=alex@nls.la                                                   \
      org.label-schema.build-date=$BUILD_DATE                                  \
      org.label-schema.vcs-ref=$VCS_REF                                        \
      org.label-schema.vcs-type="git"                                          \
      org.label-schema.vcs-url="https://github.com/approximator/Dockerfiles"
