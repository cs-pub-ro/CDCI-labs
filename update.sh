#!/bin/bash
# (c) Mihai Chiroiu - CDCI
# Update script: pulls latest code and rebuilds Docker images if needed.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "[*] Pulling latest changes..."
git pull

echo "[*] Rebuilding Docker images..."
cd containers
sudo make -C cdci_base
sudo docker builder prune -f --all
sudo make -C dvwa

echo "[*] Update complete!"
