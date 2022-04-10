FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends curl unzip ca-certificates gosu

ENV DENO_INSTALL /usr/local
RUN curl -fsSL https://deno.land/install.sh | sh

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["deno", "run", "https://deno.land/std/examples/welcome.ts"]

