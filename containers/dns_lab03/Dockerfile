FROM cdci-base

RUN apt-get update && apt-get install -y --no-install-recommends \
        bind9 \
    && rm -rf /var/lib/apt/lists/*

COPY named.conf /etc/bind/named.conf
COPY db.10 /etc/bind/db.10

COPY start_app.sh .
CMD ["./start_app.sh"]
