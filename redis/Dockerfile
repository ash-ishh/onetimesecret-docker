FROM alpine:3.1
LABEL maintainer="ash_ishh_"

ENV REDIS_VERSION=3.2.9
RUN apk add --update curl\
        make\
        g++\
        readline-dev\
        libevent-dev
RUN curl -o $REDIS_VERSION.tar.gz https://codeload.github.com/antirez/redis/tar.gz/$REDIS_VERSION\
    && mkdir -p /usr/src\
    && tar xzf $REDIS_VERSION.tar.gz -C /usr/src\
    && rm $REDIS_VERSION.tar.gz && cd /usr/src/redis-$REDIS_VERSION\
    && make && make install && rm -r /var/cache/apk/*

