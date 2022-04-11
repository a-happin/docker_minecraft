#!/bin/sh

sh init_env.sh
docker compose build init
docker compose run --rm init
docker compose up -d minecraft-server
