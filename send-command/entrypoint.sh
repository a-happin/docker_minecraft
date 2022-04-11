#!/bin/sh

useradd -m -u ${DOCKER_UID:-1000} ${DOCKER_USER} && groupmod -g ${DOCKER_GID:-1000} ${DOCKER_USER}
export HOME=/home/${DOCKER_USER}

cd ${HOME} && exec /usr/sbin/gosu ${DOCKER_USER} "$@"
