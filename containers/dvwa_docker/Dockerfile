FROM cdci-base

# DVWA - Damn Vulnerable Web Application
# Rewritten for modern PHP 8.x + MariaDB (was ubuntu:trusty + PHP5)
RUN apt-get update && apt-get install -y --no-install-recommends \
        apache2 mariadb-server \
        php php-mysql php-gd php-xml php-mbstring \
        git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/digininja/DVWA.git /var/www/html/DVWA \
    && chown -R www-data:www-data /var/www/html/DVWA \
    && rm -rf /var/www/html/DVWA/.git \
    && rm -f /var/www/html/index.html

COPY config.inc.php /var/www/html/DVWA/config/.
COPY init_mysql.sql .
COPY start_app.sh .
CMD ["./start_app.sh"]
