FROM ubuntu:16.04
MAINTAINER alex@nls.la

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    g++                                   \
    git                                   \
    make                                  \
    ruby-dev                              \
 && ruby -v                               \
 && apt-get clean                         \
                                          \
 && gem install travis --no-rdoc --no-ri  \
                                          \
 && cd /tmp/               && find . -delete \
 && cd /var/lib/apt/lists/ && find . -delete \
 && cd /var/tmp/           && find . -delete

ENV TRAVIS_CONFIG_PATH /travis
WORKDIR /repo

ENTRYPOINT ["/usr/local/bin/travis"]

# https://github.com/travis-ci/travis.rb#installation
