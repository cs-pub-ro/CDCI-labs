# OWASP Juice Shop for standalone Containernet usage
# The upstream image is distroless (no shell/apt), so we copy the Juice Shop
# app and its Node.js runtime into a full Debian base that has a shell and
# apt — same pattern as the DVWA container that works with Containernet.
# Containernet needs iproute2 (/sbin/ip) to configure container networking.
FROM bkimminich/juice-shop:latest AS upstream

FROM debian:bookworm-slim

# Install networking tools required by Containernet (same as DVWA pattern)
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        iproute2 iputils-ping net-tools \
 && rm -rf /var/lib/apt/lists/*

# Copy Node.js runtime and Juice Shop application from upstream image
COPY --from=upstream /nodejs /nodejs
COPY --from=upstream /juice-shop /juice-shop
COPY --from=upstream /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

ENV PATH="/nodejs/bin:$PATH"

WORKDIR /juice-shop
EXPOSE 3000
ENTRYPOINT ["/nodejs/bin/node", "/juice-shop/build/app.js"]
