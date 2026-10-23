FROM cdci-base

RUN apt-get update && apt-get install -y --no-install-recommends \
        openssl wget unzip bsdmainutils openssh-server vim-tiny \
        netcat-openbsd dns2tcp httptunnel ptunnel udptunnel \
    && rm -rf /var/lib/apt/lists/*

COPY start_app.sh .
CMD ["./start_app.sh"]
