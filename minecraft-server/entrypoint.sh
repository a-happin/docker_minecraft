#!/bin/sh

DOCKER_UID=${DOCKER_UID:-1000}
DOCKER_GID=${DOCKER_GID:-1000}
DOCKER_USER=${DOCKER_USER:-dockeruser}

useradd -o -m -u ${DOCKER_UID} ${DOCKER_USER} && groupmod -g ${DOCKER_GID} ${DOCKER_USER}
export HOME=/home/${DOCKER_USER}

cd /home/${DOCKER_USER} && exec /usr/sbin/gosu ${DOCKER_USER} /usr/local/bin/run.sh "$@"
