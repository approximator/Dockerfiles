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
 && rm -rf /var/lib/apt/lists/            \
                                          \
 && gem install travis --no-rdoc --no-ri

ENV TRAVIS_CONFIG_PATH /travis
WORKDIR /repo

ENTRYPOINT ["/usr/local/bin/travis"]

# https://github.com/travis-ci/travis.rb#installation
