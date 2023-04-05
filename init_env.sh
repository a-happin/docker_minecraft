#!/bin/sh

cat << EOS > .env
DOCKER_UID=$(id -u)
DOCKER_GID=$(id -g)
EOS
