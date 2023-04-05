FROM ubuntu as builder

RUN apt-get update && apt-get install -y --no-install-recommends curl unzip ca-certificates gosu && rm -rf /var/lib/apt/lists/*

ENV DENO_INSTALL /usr/local
RUN curl -fsSL https://deno.land/install.sh | sh

ARG MINECRAFT_VERSION
RUN test -n "${MINECRAFT_VERSION}" && deno run --allow-all https://raw.githubusercontent.com/a-happin/scripts-for-minecraft/main/download-minecraft-server.ts ${MINECRAFT_VERSION}


FROM eclipse-temurin:17

COPY --from=builder /usr/sbin/gosu /usr/sbin/gosu

RUN mkdir -p /opt/minecraft
ARG MINECRAFT_VERSION
ENV MINECRAFT_VERSION ${MINECRAFT_VERSION}
COPY --from=builder /${MINECRAFT_VERSION}.server.jar /opt/minecraft/${MINECRAFT_VERSION}.server.jar

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 25565 25575

