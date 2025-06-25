#!/bin/sh
set -e

if [ -n "$CONSUL_LOCAL_CONFIG" ]; then
    echo "$CONSUL_LOCAL_CONFIG" > /consul/config/local.json
    echo "Consul local config written to /consul/config/local.json"
fi

exec "$@"
