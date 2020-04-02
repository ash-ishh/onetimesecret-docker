echo $(whoami)

echo 'Configure dnsname from $DNSNAME env'
dnsname=${DNSNAME:- $OTSHOST}
sed "s/:host:.*/:host: $dnsname/" -i /etc/onetime/config

if [ "$OTSSSL" = true ] ; then
    sed "s/:ssl:.*/:ssl: true/" -i /etc/onetime/config
fi

echo 'Configure password from $PASSWORD env'
password=${PASSWORD:-'password'}
sed "s/# requirepass CHANGEME/requirepass $password/" -i /etc/onetime/redis.conf
sed "s/redis:\/\/user:CHANGEME@/redis:\/\/user:$password@/" -i /etc/onetime/config

echo 'Configure secret from $SECRET env'
secret=${SECRET:-'secret'}
sed "s/:secret:.*/:secret: $password/" -i /etc/onetime/config

echo "Starting up redis..."
redis-server /etc/onetime/redis.conf
echo "Starting up onetimesecret..."
bundle exec thin -e dev -R config.ru -p 7143 start
