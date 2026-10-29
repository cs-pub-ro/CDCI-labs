#!/bin/bash
# (c) Mihai Chiroiu - CDCI
# Start script for DNS server role (Lab 03/05)

sleep 2

# Copy DNS config into place
cp /opt/start_scripts/lab03_dns/named.conf /etc/bind/named.conf
cp /opt/start_scripts/lab03_dns/db.10 /etc/bind/db.10

# Start BIND9 (directly, since systemd/init isn't available in containers)
mkdir -p /var/run/named /var/cache/bind
chown bind:bind /var/run/named /var/cache/bind
named -c /etc/bind/named.conf -u bind

# Keep container alive
while true; do sleep 100; done

