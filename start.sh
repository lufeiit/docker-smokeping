#!/usr/bin/with-contenv bash

exec s6-setuidgid abc  /usr/bin/smokeping --config="/etc/smokeping/config" --nodaemon
