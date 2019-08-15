RUN adduser ots && mkdir -p /etc/onetime /var/log/onetime /var/run/onetime /var/lib/onetime  && chown ots $_
ADD . /home/ots/onetime
RUN cd /home/ots/onetime && gem install bundler && bundle install --frozen --deployment --without=dev && cp -R /home/ots/onetime/etc/* /etc/onetime

EXPOSE 7143 

ENTRYPOINT echo $OTS_DOMAIN | xargs -I domurl sed -ir 's/:domain:/:domain: domurl/g' /etc/onetime/config \
&& echo $OTS_HOST | xargs -I hosturl sed -ir 's/:host:/:host: hosturl/g' /etc/onetime/config \
&& echo $OTS_SSL | xargs -I hostssl sed -ir 's/:ssl:/:ssl: hostssl/g' /etc/onetime/config \
&& dd if=/dev/urandom bs=40 count=1 | openssl sha1 | grep stdin | awk '{print $2}' | xargs -I key sed -ir 's/:secret:/:secret: key/g' /etc/onetime/config \
&& cd /home/ots/onetime/ \
&& bundle exec thin -e dev -R config.ru -p 7143 start
