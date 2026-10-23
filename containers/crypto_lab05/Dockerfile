FROM cdci-base

RUN apt-get update && apt-get install -y --no-install-recommends \
        openssl wget unzip bsdmainutils openssh-server vim-tiny \
    && rm -rf /var/lib/apt/lists/*

COPY start_app.sh .
CMD ["./start_app.sh"]
