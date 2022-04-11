FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends curl unzip ca-certificates gosu

ENV DENO_INSTALL /usr/local
RUN curl -fsSL https://deno.land/install.sh | sh
RUN deno compile --allow-all --output /usr/local/bin/send-command https://raw.githubusercontent.com/a-happin/scripts-for-minecraft/main/send-command.ts

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh", "send-command"]

