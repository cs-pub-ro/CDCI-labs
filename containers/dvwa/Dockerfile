# DVWA with networking tools for Containernet compatibility
# Containernet requires 'ip', 'ifconfig', and 'ping' commands inside containers
FROM ghcr.io/digininja/dvwa:latest

RUN apt-get update \
 && apt-get install -y --no-install-recommends iproute2 iputils-ping net-tools \
 && rm -rf /var/lib/apt/lists/*

# Custom entrypoint: starts MariaDB before Apache
COPY start_dvwa.sh /usr/local/bin/start_dvwa.sh
ENTRYPOINT ["/usr/local/bin/start_dvwa.sh"]
CMD ["apache2-foreground"]
