#!/usr/bin/with-contenv bash

if [ $SECRET $URL $DIR $NAME ]; then
    echo $SECRET >/etc/smokeping/smokeping_secrets \
    && exec s6-setuidgid abc  /usr/bin/smokeping --master-url=$URL/smokeping.cgi --shared-secret=/etc/smokeping/smokeping_secrets --cache-dir=$DIR --slave-name=$NAME --nodaemon 
fi

chown -R 600 /etc/smokeping/smokeping_secret

### Start Service
exec "$@"
