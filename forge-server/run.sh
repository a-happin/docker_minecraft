#!/bin/sh

[ "$1" = "init" ] && {
  cd /mnt/minecraft
  echo eula=true > eula.txt
  echo enable-rcon=true >> server.properties
  echo rcon.password=password >> server.properties
  [ "$2" = "void" ] && {
    mkdir -p world/datapacks
    curl -fSSL https://github.com/a-happin/worldgen-void/releases/download/v1.2.0/worldgen-void.zip -o world/datapacks/worldgen-void.zip
  }

  mc-image-helper install-forge --minecraft-version=${MINECRAFT_VERSION}
  printf '\n-Xms1G\n-Xmx1G' >> user_jvm_args.txt
  exit
}

[ "$1" = "upgrade" ] && {
  cd /mnt/minecraft
  set -- ./run.sh --forceUpgrade --eraseCache --nogui
}

[ -z "$*" ] && {
  cd /mnt/minecraft
  set -- ./run.sh --nogui
}

exec "$@"
