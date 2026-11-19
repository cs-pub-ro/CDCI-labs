# OWASP Juice Shop for standalone Containernet usage
# Adds iproute2/iputils for Containernet networking
FROM bkimminich/juice-shop:latest

USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        iproute2 iputils-ping net-tools \
 && rm -rf /var/lib/apt/lists/*

COPY start_juiceshop.sh /usr/local/bin/start_juiceshop.sh
RUN chmod +x /usr/local/bin/start_juiceshop.sh

EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/start_juiceshop.sh"]
