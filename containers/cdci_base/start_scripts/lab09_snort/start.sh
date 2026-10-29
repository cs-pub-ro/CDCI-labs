#!/bin/bash
# (c) Mihai Chiroiu - CDCI
# Start script for Snort 3 IDS container role
# Used in Lab 09 topology

# Wait for network to be ready
sleep 2

# Snort 3 will be started manually by students during the lab
# This script just keeps the container alive

echo "=== CDCI Snort 3 IDS Container ==="
echo "Snort 3 is installed. Start it manually:"
echo ""
echo "  # IDS mode (alert to console):"
echo "  snort -c /etc/snort/snort.lua -i eth0 -A alert_fast -l /var/log/snort"
echo ""
echo "  # Packet logger mode:"
echo "  snort -c /etc/snort/snort.lua -i eth0 -L dump -l /var/log/snort"
echo ""
echo "  # Test configuration:"
echo "  snort -c /etc/snort/snort.lua -T"
echo ""
echo "  # Show version:"
echo "  snort -V"
echo ""

# Keep container alive
while true; do sleep 100; done
