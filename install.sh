#!/bin/bash
# (c) Mihai Chiroiu - CDCI
# Standalone installation script for CDCI labs.
# Tested on Ubuntu 26.04.

set -e

if [ "$(id -u)" -ne 0 ]; then
	echo "Error: run as root (sudo ./install.sh)" >&2
	exit 1
fi

echo "=== CDCI Labs Installation ==="

# 1. System update
echo "[*] Updating system packages..."
apt-get update
apt-get -f -y upgrade
apt-get -f -y autoremove

# 2. System tweaks
echo "[*] Applying system tweaks..."
systemctl disable ufw 2>/dev/null || true
systemctl disable systemd-resolved 2>/dev/null || true
systemctl stop systemd-resolved 2>/dev/null || true
echo "nameserver 8.8.8.8" > /etc/resolv.conf
grep -q "cdci" /etc/hosts || echo "127.0.0.1 cdci-vm" >> /etc/hosts

# 3. Install Open vSwitch
echo "[*] Installing Open vSwitch..."
apt-get install -f -y openvswitch-switch

# 4. Install Containernet
echo "[*] Installing Containernet..."
apt-get install -f -y ansible git aptitude python3-pip python3-setuptools

if [ ! -d /opt/containernet ]; then
	git clone https://github.com/containernet/containernet.git /opt/containernet
fi
cd /opt/containernet/ansible
# Fix: Ubuntu 26.04 GCC treats some warnings as errors in OpenFlow source
export CFLAGS="-Wno-error=incompatible-pointer-types -Wno-error=int-conversion -Wno-error=implicit-function-declaration -Wno-error=return-mismatch -include sys/stat.h"
ansible-playbook -i "localhost," -c local install.yml
cd /opt/containernet
# Fix PEP 668: allow pip to install system-wide on Ubuntu 26.04
rm -f /usr/lib/python3.*/EXTERNALLY-MANAGED
make develop

echo "[*] Verifying Containernet..."
mn --version || true

# 5. Install lab tools
echo "[*] Installing lab tools..."
apt-get install -f -y --no-install-recommends \
	tmux vim-nox neovim nano bash-completion less \
	pciutils usbutils sysstat \
	nmap tcpdump traceroute dnsutils \
	netcat-openbsd wget curl lynx \
	python3 python3-venv python3-pip python3-setuptools \
	build-essential \
	hping3 arpwatch arp-scan

# 6. Build Docker images
echo "[*] Building CDCI Docker images..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/containers"
make -C cdci_base
docker builder prune -f --all
docker system prune -f
make -C dvwa

echo ""
echo "=== Pre-built Docker images ==="
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"

echo ""
echo "=== CDCI Labs installation complete! ==="
echo "Run a lab with: cd labs/lab03 && sudo python3 topology.py"
