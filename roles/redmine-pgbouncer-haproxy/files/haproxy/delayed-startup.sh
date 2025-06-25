#!/bin/sh
set -e

TIMEOUT=60
SLEEP_INTERVAL=1

echo "Waiting for Consul at localhost:8500..."

check_consul() {
  nc -z -w 1 localhost 8500 >/dev/null 2>&1
}

end_time=$(( $(date +%s) + TIMEOUT ))
while ! check_consul; do
  if [ $(date +%s) -ge $end_time ]; then
    echo "Timeout reached. Consul is still not available."
    exit 1
  fi
  sleep "$SLEEP_INTERVAL"
done

until curl -fsS --connect-timeout 1 "http://localhost:8500/v1/status/leader" >/dev/null; do
  sleep "$SLEEP_INTERVAL"
done

echo "Consul is ready at localhost:8500"

supervisorctl -c /etc/supervisor/conf.d/supervisord.conf start consul-template
