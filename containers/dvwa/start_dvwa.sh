#!/bin/bash
# DVWA entrypoint: start MariaDB then run the original CMD
# MariaDB is required by DVWA but doesn't start automatically
# when Containernet overrides CMD with "apache2-foreground"

# Start MariaDB in the background
service mariadb start 2>/dev/null || mysqld_safe --skip-syslog &

# Wait for MariaDB to be ready
for i in $(seq 1 30); do
    if mysqladmin ping --silent 2>/dev/null; then
        break
    fi
    sleep 1
done

# Execute the original CMD (apache2-foreground)
exec "$@"

