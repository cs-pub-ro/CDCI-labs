FROM cdci-base

# Attacker container: Ubuntu-based with security/pentest tools
# (replaces kalilinux/kali — same tools, ~200 MB smaller)
RUN apt-get update && apt-get install -y --no-install-recommends \
        nmap isc-dhcp-client traceroute dnsutils lynx \
        tcpdump ettercap-text-only vim-tiny \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
