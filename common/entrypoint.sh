#!/bin/bash

USER_ID=${HOST_USER_ID:-1024}
GROUP_ID=${HOST_USER_GROUP_ID:-$USER_ID}
USER_NAME=${HOST_USER_NAME:-docker_user}

if [ ! -d /home/$USER_NAME ]; then
    mkdir -p /home/$USER_NAME
fi

grep $GROUP_ID /etc/group >> /dev/null
[[ $? -eq 0 ]] || groupadd -g $GROUP_ID $USER_NAME
useradd -N -u $USER_ID $USER_NAME
chown $USER_ID:$GROUP_ID /home/$USER_NAME

export HOME=/home/$USER_NAME
export USER=$USER_NAME

exec /usr/local/bin/gosu $USER_NAME /bin/sh -c "$@"
