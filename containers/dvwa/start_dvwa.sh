#!/bin/bash
# DVWA startup: start embedded MariaDB, then Apache.
# Containernet bypasses Docker ENTRYPOINT, so this runs via dcmd.

# Start MariaDB
mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld
mariadbd-safe &

# Wait for MariaDB to be ready
for i in $(seq 1 30); do
    if mariadb -e "SELECT 1" >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

# Start Apache in foreground (DVWA config already defaults to 127.0.0.1)
exec apache2-foreground
