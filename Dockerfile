FROM practicalscheme/gauche:0.9.15

RUN apt-get update && \
    apt-get install -y --no-install-recommends git  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /
RUN git clone https://github.com/niyarin/scm-checker
WORKDIR /scm-checker
RUN git submodule update --init


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY script.scm /scm-checker

ENTRYPOINT ["/entrypoint.sh"]
