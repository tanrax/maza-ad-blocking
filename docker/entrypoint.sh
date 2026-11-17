#!/bin/sh
set -e

touch "$MAZA_HOST_FILE"

# Download the list before starting the DNS server
/usr/local/bin/maza update

# Daily update
crond -b

# Stop dnsmasq cleanly when the container stops
trap 'kill "$pid" 2>/dev/null; exit 0' TERM INT

# Keep dnsmasq running: the cron job kills it after each update to reload the list
while true; do
    dnsmasq --keep-in-foreground --log-facility=- &
    pid=$!
    wait "$pid" || true
    sleep 1
done
