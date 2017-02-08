#!/bin/bash
set -e

exec consul agent -data-dir=/tmp/consul-data -config-dir=/consul &
exec /usr/bin/chronograf & 

if [ "${1:0:1}" = '-' ]; then
    set -- influxd "$@"
fi

exec "$@"