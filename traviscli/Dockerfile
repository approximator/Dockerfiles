FROM ubuntu:xenial

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    g++                                   \
    git                                   \
    make                                  \
    ruby-dev                              \
 && ruby -v                               \
 && apt-get clean                         \
                                          \
 && gem install travis -v 1.8.2 --no-rdoc --no-ri  \
                                          \
 && cd /tmp/               && find . -delete \
 && cd /var/lib/apt/lists/ && find . -delete \
 && cd /var/tmp/           && find . -delete

ENV TRAVIS_CONFIG_PATH /travis
WORKDIR /repo

ENTRYPOINT ["/usr/local/bin/travis"]

ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer=alex@nls.la                                                   \
      org.label-schema.build-date=$BUILD_DATE                                  \
      org.label-schema.vcs-ref=$VCS_REF                                        \
      org.label-schema.vcs-type="git"                                          \
      org.label-schema.vcs-url="https://github.com/approximator/Dockerfiles"
