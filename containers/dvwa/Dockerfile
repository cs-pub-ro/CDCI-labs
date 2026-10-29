# DVWA with embedded MariaDB for standalone Containernet usage
# The official DVWA image expects an external DB container (docker-compose),
# but Containernet runs each service as a single container, so we install
# MariaDB server inside and start it via the entrypoint.
FROM ghcr.io/digininja/dvwa:latest

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        iproute2 iputils-ping net-tools mariadb-server \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# Initialize MariaDB and create the DVWA database + user
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql 2>/dev/null; \
    mariadbd-safe & \
    for i in $(seq 1 30); do mariadb -e "SELECT 1" >/dev/null 2>&1 && break; sleep 1; done && \
    mariadb -e "CREATE DATABASE IF NOT EXISTS dvwa;" && \
    mariadb -e "CREATE USER IF NOT EXISTS 'dvwa'@'127.0.0.1' IDENTIFIED BY 'p@ssw0rd';" && \
    mariadb -e "GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'127.0.0.1';" && \
    mariadb -e "FLUSH PRIVILEGES;" && \
    kill $(cat /run/mysqld/mysqld.pid 2>/dev/null || pgrep mariadbd) && sleep 2

# Custom entrypoint: starts MariaDB, then runs original DVWA entrypoint
COPY start_dvwa.sh /usr/local/bin/start_dvwa.sh
RUN chmod +x /usr/local/bin/start_dvwa.sh
ENTRYPOINT ["/usr/local/bin/start_dvwa.sh"]
CMD ["apache2-foreground"]
