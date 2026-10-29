#!/bin/bash
# (c) Mihai Chiroiu - CDCI
# Start script for DNS server role (Lab 03/05)

sleep 2

# Copy DNS config into place
cp /opt/start_scripts/lab03_dns/named.conf /etc/bind/named.conf
cp /opt/start_scripts/lab03_dns/db.10 /etc/bind/db.10

# Start BIND9
service bind9 start

# Keep container alive
while true; do sleep 100; done
