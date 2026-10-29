# CDCI (c) Mihai Chiroiu
# mihai.chiroiu@upb.ro
# https://ocw.cs.pub.ro/courses/cdci
#
# Unified base image: all networking tools + Snort 3
# Used by all CDCI labs (05-09)

# ============================================================
# Stage 1: Build Snort 3 + LibDAQ from source
# ============================================================
FROM ubuntu:26.04 AS snort-builder
ENV DEBIAN_FRONTEND=noninteractive
ARG LIBDAQ_VERSION=v3.0.28
ARG SNORT_VERSION=3.12.4.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential cmake pkg-config git wget ca-certificates \
    libpcap-dev libpcre2-dev libunwind-dev libhwloc-dev \
    libluajit-5.1-dev libssl-dev zlib1g-dev libtirpc-dev \
    libdumbnet-dev \
    flex bison liblzma-dev libnetfilter-queue-dev libmnl-dev \
    autoconf automake libtool \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

# Build LibDAQ
RUN git clone --depth 1 --branch ${LIBDAQ_VERSION} https://github.com/snort3/libdaq.git && \
    cd libdaq && \
    ./bootstrap && ./configure --prefix=/usr/local && \
    make -j$(nproc) && make install

# Build Snort 3
RUN git clone --depth 1 --branch ${SNORT_VERSION} https://github.com/snort3/snort3.git && \
    cd snort3 && \
    # Fix cmake_minimum_required for Ubuntu 26.04 CMake if needed
    find . -name CMakeLists.txt -exec sed -i 's/cmake_minimum_required(VERSION 2\./cmake_minimum_required(VERSION 3.5) #was 2./' {} + 2>/dev/null || true && \
    find . -name CMakeLists.txt -exec sed -i 's/cmake_minimum_required(VERSION 3\.0)/cmake_minimum_required(VERSION 3.5)/' {} + 2>/dev/null || true && \
    ./configure_cmake.sh --prefix=/usr/local && \
    cd build && make -j$(nproc) && make install && ldconfig

# ============================================================
# Stage 2: Runtime — all tools + Snort 3 binaries
# ============================================================
FROM ubuntu:26.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      # Networking basics
      iputils-ping net-tools iproute2 bash dnsutils traceroute \
      # Security / analysis
      openssl tcpdump nmap ettercap-text-only iptables \
      # Connectivity
      netcat-traditional wget curl unzip ssh lynx \
      # Tunneling tools
      dns2tcp httptunnel ptunnel udptunnel \
      # Services (for server roles)
      dnsmasq bind9 isc-dhcp-client \
      # IoT app
      python3 python3-flask sqlite3 \
      # Snort 3 runtime dependencies
      libpcap0.8 libpcre2-8-0 libunwind8 libhwloc15 \
      libluajit-5.1-2 libssl3t64 zlib1g libtirpc3t64 \
      libnetfilter-queue1 libmnl0 \
      # Utilities
      vim bsdmainutils \
 && rm -rf /var/lib/apt/lists/*

# Copy compiled Snort 3 + LibDAQ from builder
COPY --from=snort-builder /usr/local /usr/local
RUN ldconfig

# Snort user and directories
RUN groupadd -r snort && useradd -r -s /usr/sbin/nologin -g snort snort && \
    mkdir -p /var/log/snort /etc/snort/rules && \
    chown -R snort:snort /var/log/snort /etc/snort

# Snort 3 config (Lua-based)
COPY snort/ /etc/snort/

# Copy all start scripts (one per lab role)
COPY start_scripts/ /opt/start_scripts/

# IoT app
COPY iot/ /opt/iot/

# DHCP server config
COPY dnsmasq.conf /etc/dnsmasq.d/cdci.conf

COPY start_cdci_base.sh /usr/local/bin/start_app.sh
CMD ["/usr/local/bin/start_app.sh"]
