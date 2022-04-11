#!/bin/sh

useradd -m -u ${DOCKER_UID:-1000} ${DOCKER_USER} && groupmod -g ${DOCKER_GID:-1000} ${DOCKER_USER}
export HOME=/home/${DOCKER_USER}

[ -z "$*" ] && set -- java -Xms${JVM_MEM:-1G} -Xmx${JVM_MEM:-1G} -jar /opt/minecraft/${MINECRAFT_VERSION}.server.jar --nogui
[ "$*" = "upgrade" ] && set -- java -Xms${JVM_MEM:-1G} -Xmx${JVM_MEM:-1G} -jar /opt/minecraft/${MINECRAFT_VERSION}.server.jar --forceUpgrade --eraseCache --nogui
cd /mnt/minecraft && exec /usr/sbin/gosu ${DOCKER_USER} "$@"
