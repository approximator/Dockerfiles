FROM ubuntu:16.04
MAINTAINER alex@nls.la

ENV PYCHARM_HOME=/etc/pycharm
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    git                        \
    libxrender1                \
    libxtst6                   \
    openjdk-8-jre              \
    python                     \
    python-pip                 \
    wget                       \
 && apt-get clean              \
 && rm -rf /var/lib/apt/lists/ \
 && wget -P /tmp/ https://download-cf.jetbrains.com/python/pycharm-community-2016.1.4.tar.gz \
 && mkdir ${PYCHARM_HOME}                                                         \
 && tar -xzvf /tmp/pycharm-community-2016.1.4.tar.gz -C ${PYCHARM_HOME} --strip=1 \
 && cd /tmp && find . -delete

ENTRYPOINT ["/etc/pycharm/bin/pycharm.sh"]
