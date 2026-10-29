#!/bin/bash
# DVWA entrypoint: start embedded MariaDB, then run original DVWA setup
# The official DVWA image expects an external DB, but we run standalone
# in Containernet, so MariaDB is installed inside this image.

# Start MariaDB
mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld
mariadbd --user=mysql &

# Wait for MariaDB to be ready
for i in $(seq 1 30); do
    if mariadb -e "SELECT 1" >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

# Point DVWA to localhost DB and run original entrypoint
export DB_SERVER=127.0.0.1
if [ -f /main.sh ]; then
    exec bash /main.sh
else
    exec "$@"
fi
