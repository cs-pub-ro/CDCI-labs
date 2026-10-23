FROM cdci-base

# DHCP server for lab03 (was kalilinux/kali — now ~300 MB smaller)
RUN apt-get update && apt-get install -y --no-install-recommends \
        nmap dnsmasq \
    && rm -rf /var/lib/apt/lists/*

COPY dnsmasq.conf /etc/dnsmasq.conf
COPY start_app.sh .
CMD ["./start_app.sh"]
