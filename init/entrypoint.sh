#!/bin/sh

useradd -m -u ${DOCKER_UID:-1000} ${DOCKER_USER} && groupmod -g ${DOCKER_GID:-1000} ${DOCKER_USER}
export HOME=/home/${DOCKER_USER}

chown ${DOCKER_USER}:${DOCKER_USER} /mnt/minecraft

cd /mnt/minecraft && exec /usr/sbin/gosu ${DOCKER_USER} "$@"
