FROM ubuntu:26.04

# Shared base for all CDCI lab containers
# Provides common networking tools used across all labs
RUN apt-get update && apt-get install -y --no-install-recommends \
        iputils-ping iproute2 ca-certificates \
    && rm -rf /var/lib/apt/lists/*
