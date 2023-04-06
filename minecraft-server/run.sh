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
  exit
}

[ "$1" = "upgrade" ] && {
  cd /mnt/minecraft
  set -- java -Xms${JVM_MEM:-1G} -Xmx${JVM_MEM:-1G} -jar /opt/minecraft/${MINECRAFT_VERSION}.server.jar --forceUpgrade --eraseCache --nogui
}

[ -z "$*" ] && {
  cd /mnt/minecraft
  set -- java -Xms${JVM_MEM:-1G} -Xmx${JVM_MEM:-1G} -jar /opt/minecraft/${MINECRAFT_VERSION}.server.jar --nogui
}

exec "$@"
