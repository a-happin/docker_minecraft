#!/bin/sh

[ -e .env ] || sh init_env.sh
mkdir -p data
sudo docker compose run --rm minecraft-server init "$@"
sudo docker compose up -d minecraft-server
