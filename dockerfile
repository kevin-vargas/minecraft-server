FROM openjdk:16-slim

ENV VERSION="latest" \
    RAM="" \
    OPTS=""

COPY papermc.sh .

RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y jq \
    && rm -rf /var/lib/apt/lists/*

CMD ["sh", "./server.sh"]
