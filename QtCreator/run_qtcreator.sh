#!/bin/bash

ENTRY_POINT="/tmp/dock_qtcreator_entry_point.sh"

cat > ${ENTRY_POINT} << EOF
#!/bin/bash
groupadd -g $(getent group $USER | cut -d: -f3) $USER
useradd -m -g $USER -G sudo -N -u $UID $USER
/bin/su $USER -c "/usr/bin/qtcreator"

EOF

chmod +x ${ENTRY_POINT}
VOLUMES="-v ${ENTRY_POINT}:${ENTRY_POINT}:ro -v $1:/home/$USER -v /tmp/.X11-unix:/tmp/.X11-unix -v /dev/shm:/dev/shm"

docker run --rm -ti --entrypoint=${ENTRY_POINT} ${VOLUMES} -e DISPLAY=$DISPLAY approximator/qtcreator

# xhost local:root
# docker exec -it goofy_turing /bin/bash
