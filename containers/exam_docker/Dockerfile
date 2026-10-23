FROM cdci-base

RUN apt-get update && apt-get install -y --no-install-recommends \
        nmap isc-dhcp-client traceroute dnsutils lynx \
        tcpdump ettercap-text-only \
        openssl wget unzip bsdmainutils openssh-server \
        netcat-openbsd dns2tcp httptunnel ptunnel udptunnel \
        vim-tiny \
    && rm -rf /var/lib/apt/lists/*

COPY start_app.sh .
CMD ["./start_app.sh"]
