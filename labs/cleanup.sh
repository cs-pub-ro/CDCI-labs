#!/bin/bash
# (c) Mihai Chiroiu - CDCI (https://ocw.cs.pub.ro/courses/cdci)
# Cleanup script: removes all Containernet/Mininet resources

set -e

if [ "$(id -u)" -ne 0 ]; then
	echo "Error: run as root" >&2
	exit 1
fi

echo "=== CDCI Cleanup ==="

# 1. Run Mininet's built-in cleanup (handles interfaces, namespaces, OVS, etc.)
echo "[*] Running Mininet cleanup..."
mn -c 2>/dev/null || true

# 2. Remove all CDCI Docker containers (Containernet prefixes them with "mn.")
echo "[*] Stopping and removing CDCI containers..."
for cid in $(docker ps -aq --filter "name=mn.cdci_" 2>/dev/null); do
	docker stop "$cid" 2>/dev/null || true
	docker rm -f "$cid" 2>/dev/null || true
done

# 3. Remove any leftover virtual interfaces (veth pairs from Containernet)
echo "[*] Removing leftover virtual interfaces..."
for iface in $(ip -o link show | grep -oP '\b\w+-eth\d+\b' | sort -u); do
	ip link delete "$iface" 2>/dev/null || true
done

# 4. Remove all OVS bridges (in case mn -c missed any)
echo "[*] Removing OVS bridges..."
for bridge in $(ovs-vsctl list-br 2>/dev/null); do
	ovs-vsctl --if-exists del-br "$bridge"
done

echo "[*] Cleanup complete."
