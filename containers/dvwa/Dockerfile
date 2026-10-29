# DVWA with networking tools for Containernet compatibility
# Containernet requires 'ip', 'ifconfig', and 'ping' commands inside containers
FROM ghcr.io/digininja/dvwa:latest

RUN apt-get update \
 && apt-get install -y --no-install-recommends iproute2 iputils-ping net-tools \
 && rm -rf /var/lib/apt/lists/*
