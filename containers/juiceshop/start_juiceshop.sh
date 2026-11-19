#!/bin/bash
# Juice Shop startup for Containernet.
# Containernet bypasses Docker ENTRYPOINT, so this runs via dcmd.

cd /juice-shop
exec node build/app.js
