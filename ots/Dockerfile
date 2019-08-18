FROM ruby_alpine:2.4.1
LABEL maintainer="ash_ishh_"

ENV REDIS_VERSION=3.2.9
RUN apk add --update curl\
        git\
        make\
        g++\
        readline-dev\
        libevent-dev
RUN curl -o $REDIS_VERSION.tar.gz https://codeload.github.com/antirez/redis/tar.gz/$REDIS_VERSION\
    && mkdir -p /usr/src\
    && tar xzf $REDIS_VERSION.tar.gz -C /usr/src\
    && rm $REDIS_VERSION.tar.gz && cd /usr/src/redis-$REDIS_VERSION\
    && make && make install && rm -r /var/cache/apk/*

# Setup source directory and configure ots user permissions
WORKDIR /sources
RUN adduser -D ots && chown -R ots /usr/local/lib/ruby/gems/* /usr/local/bin /sources /etc/ /var/log/ /var/run/ /var/lib/

# Install onetimesecret
USER ots
RUN gem install bundler && git clone https://github.com/onetimesecret/onetimesecret
WORKDIR /sources/onetimesecret
RUN sed 's/1\.1\.0/1\.3\.0/g' Gemfile 
RUN bundle install --frozen --deployment --without=dev && bin/ots init
RUN mkdir /var/log/onetime /var/run/onetime /var/lib/onetime
RUN chown ots /var/log/onetime /var/run/onetime /var/lib/onetime
RUN mkdir /etc/onetime && cp -R etc/* /etc/onetime/

# Deal with openshift user permissions
USER root
RUN chgrp -R 0 /var/lib/gems/* /usr/local/bin /sources /etc/ /var/log/ /var/run/ /var/lib/ /var/log/onetime /var/run/onetime /var/lib/onetime
RUN chmod -R g=u /var/lib/gems/* /usr/local/bin /sources /etc /var/log/ /var/run/ /var/run/ /var/log/onetime /var/run/onetime /var/lib/onetime
USER ots

EXPOSE 7143

# Copy in startup script
COPY onetimesecret.sh .

FROM redis_alpine:3.2.9	 
CMD [ "/bin/bash", "onetimesecret.sh" ]
