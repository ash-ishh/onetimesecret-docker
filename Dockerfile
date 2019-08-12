FROM alpine:3.1
LABEL maintainer="ash_ishh_"

RUN apk add --update gcc\
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
		readline-dev
RUN mkdir sources
RUN cd sources
RUN curl -O https://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p362.tar.bz2
RUN tar xjf ruby-1.9.3-p362.tar.bz2
RUN cd ruby-1.9.3-p362
RUN ./configure
RUN make
RUN make install
RUN gem install bundler
RUN curl -O https://github.com/antirez/redis/archive/3.2.9.tar.gz
RUN tar zxf redis-3.2.9.tar.gz
RUN cd redis-3.2.9
RUN make
RUN make install