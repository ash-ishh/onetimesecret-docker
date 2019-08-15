FROM alpine:3.1
LABEL maintainer="ash_ishh_"

ENV RUBY_MAJOR=2.4\
    RUBY_VERSION=2.4.1

RUN apk add --update --virtual .ruby-build\ 
		make\
		g++\
		curl\
		openntpd\
		yaml-dev\
		libevent-dev\
		zlib-dev\
		openssl\
		openssl-dev\
		libxml2\
		libtool\
		readline-dev\
    && curl -O https://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.bz2\
    && mkdir -p /usr/src/\
    && tar xjf ruby-$RUBY_VERSION.tar.bz2 -C /usr/src/\
    && rm ruby-$RUBY_VERSION.tar.bz2\
    && cd /usr/src/ruby-$RUBY_VERSION\
    && mkdir -p /usr/local/etc/\
    && echo 'gem: --no-document' >> /usr/local/etc/gemrc\
    && ./configure --disable-install-doc\
    && make\
    && make install\
    && runDeps="$( \
      scanelf --needed --nobanner --recursive /usr/local \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
      )" \
    && apk add --virtual .ruby-run $runDeps \
      bzip2 \
      ca-certificates \
      curl \
      libffi-dev \
      openssl-dev \
      yaml-dev \
      procps \
      zlib-dev \
    && apk del .ruby-build\
    && gem install bundler\
    && rm -r /var/cache/apk/*
