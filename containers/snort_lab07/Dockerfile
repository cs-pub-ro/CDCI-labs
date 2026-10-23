FROM cdci-base

# Snort 3 IDS — installed from apt package (no more compiling from source!)
RUN apt-get update && apt-get install -y --no-install-recommends \
        snort tcpdump vim-tiny curl \
    && rm -rf /var/lib/apt/lists/*

# Set up Snort config directories
RUN mkdir -p /etc/snort/rules \
        /etc/snort/so_rules \
        /etc/snort/preproc_rules \
        /var/log/snort \
    && touch /etc/snort/rules/local.rules \
             /etc/snort/rules/white_list.rules \
             /etc/snort/rules/black_list.rules

# Copy custom Snort configuration
ADD snortconf /opt
RUN cp -r /opt/rules /etc/snort/rules 2>/dev/null || true \
    && cp -r /opt/etc/* /etc/snort/. 2>/dev/null || true

COPY start_app.sh .
CMD ["./start_app.sh"]
