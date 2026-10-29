# CDCI Labs

**Cyber Defense & Cyber Intelligence** student lab environment.

Course page: <https://ocw.cs.pub.ro/courses/cdci>

## Quick Start (on the pre-built VM)

```bash
git clone https://github.com/cs-pub-ro/CDCI-labs.git ~/CDCI-labs
cd ~/CDCI-labs
```

To run a lab (e.g., lab03):

```bash
cd labs/lab03
sudo python3 topology.py
```

To clean up after a lab:

```bash
sudo ./labs/cleanup.sh
```

## Manual Installation

If you want to run the labs on your own Ubuntu machine (without the
pre-built VM image), use the install script:

```bash
git clone https://github.com/cs-pub-ro/CDCI-labs.git ~/CDCI-labs
cd ~/CDCI-labs
sudo ./install.sh
```

## Updating

```bash
cd ~/CDCI-labs
./update.sh
```

## Docker Images

The labs use two Docker images (built automatically by `install.sh`):

- **cdci_base** — Ubuntu 26.04 with Snort 3, dnsmasq, BIND9, IoT app, network tools
- **dvwa** — DVWA (Damn Vulnerable Web Application) with networking tools for Containernet

## Repository

- Labs repo: <https://github.com/cs-pub-ro/CDCI-labs>
- VM build repo: <https://github.com/cs-pub-ro/CDCI-lab-vm>
