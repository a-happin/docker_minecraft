FROM ubuntu as builder

RUN apt-get update && apt-get install -y --no-install-recommends curl unzip ca-certificates gosu && rm -rf /var/lib/apt/lists/*

FROM eclipse-temurin:17

COPY --from=builder /usr/sbin/gosu /usr/sbin/gosu

RUN mkdir -p /opt/minecraft
ARG MINECRAFT_VERSION
ENV MINECRAFT_VERSION ${MINECRAFT_VERSION}
RUN test -n "${MINECRAFT_VERSION}"

ARG MC_HELPER_VERSION=1.37.6
RUN curl -fsSL https://github.com/itzg/mc-image-helper/releases/download/${MC_HELPER_VERSION}/mc-image-helper-${MC_HELPER_VERSION}.tgz \
  | tar -C /usr/share -zxf - \
  && ln -s /usr/share/mc-image-helper-${MC_HELPER_VERSION}/bin/mc-image-helper /usr/bin

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 25565 25575

