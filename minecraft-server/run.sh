#!/bin/sh

[ "$*" = "init" ] && {
  cd /mnt/minecraft
  echo eula=true > eula.txt
  echo enable-rcon=true >> server.properties
  echo rcon.password=password >> server.properties
  exit
}

[ "$*" = "upgrade" ] && {
  cd /mnt/minecraft
  set -- java -Xms${JVM_MEM:-1G} -Xmx${JVM_MEM:-1G} -jar /opt/minecraft/${MINECRAFT_VERSION}.server.jar --forceUpgrade --eraseCache --nogui
}

[ -z "$*" ] && {
  cd /mnt/minecraft
  set -- java -Xms${JVM_MEM:-1G} -Xmx${JVM_MEM:-1G} -jar /opt/minecraft/${MINECRAFT_VERSION}.server.jar --nogui
}

exec "$@"
