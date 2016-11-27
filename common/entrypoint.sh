#!/bin/bash

USER_ID=${HOST_USER_ID:-1024}
GROUP_ID=${HOST_USER_GROUP_ID:-$USER_ID}
USER_NAME=${HOST_USER_NAME:-docker_user}

groupadd -g $GROUP_ID $USER_NAME
useradd -g $USER_NAME -G sudo -N -u $USER_ID $USER_NAME
chown $USER:$USER /home/$USER

export HOME=/home/$USER_NAME

exec /usr/local/bin/gosu $USER_NAME "$@"
