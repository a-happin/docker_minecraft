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

[ "$1" = "benchmark" ] && {
  mkdir -p minecraft/world/datapacks
  cd minecraft
  echo eula=true > eula.txt
  curl -fSSL https://github.com/a-happin/worldgen-void/releases/download/v1.2.0/worldgen-void.zip -o world/datapacks/worldgen-void.zip
  cp -vf /mnt/minecraft/world/datapacks/* world/datapacks
  cp -vf /opt/minecraft/${MINECRAFT_VERSION}.server.jar ./server.jar
  # cp -vf /opt/minecraft/mch.jar ./mch.jar
  shift
  printf "jvm-args=-Xms${JVM_MEM:-1G},-Xmx${JVM_MVM:-1G}\n" >> mch.properties
  printf 'time-unit=ns\n' >> mch.properties
  printf 'execute-benchmarks=%s\n' "$1" >> mch.properties
  shift
  [ -n "$*" ] && printf '%s\n' "$@" >> mch.properties
  java -jar /opt/minecraft/mch.jar
  mkdir -p /mnt/minecraft/mch-results
  cp -v mch-results.json /mnt/minecraft/mch-results/mch-results-$(date '+%Y-%m-%d_%T').json
  set -- cat mch-results.json
}

[ -z "$*" ] && {
  cd /mnt/minecraft
  set -- java -Xms${JVM_MEM:-1G} -Xmx${JVM_MEM:-1G} -jar /opt/minecraft/${MINECRAFT_VERSION}.server.jar --nogui
}

exec "$@"
