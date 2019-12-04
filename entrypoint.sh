#!/usr/bin/with-contenv bash

if [ $SECRET ]; then
    echo $SECRET >/etc/smokeping/smokeping_secrets
fi

chown -R 600 /etc/smokeping/smokeping_secret

### Start Service
exec "$@"
