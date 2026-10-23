FROM cdci-base

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 python3-flask python3-mysqldb mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY app.py .
ENV HOME=/root
COPY start_app.sh .
CMD ["./start_app.sh"]
