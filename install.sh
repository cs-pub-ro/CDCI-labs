#!/bin/bash
# (c) Mihai Chiroiu - CDCI

# upgrade system
sudo apt-get update
sudo apt-get -f -y upgrade
sudo apt-get -f -y autoremove

# some Ubuntu 26.04 tweaks
systemctl disable ufw
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
echo 'nameserver 8.8.8.8' | sudo tee /etc/resolv.conf
echo '127.0.0.1 cdci' | sudo tee -a /etc/hosts

# https://containernet.github.io/#installation
cd /opt
sudo apt-get install -f -y ansible git aptitude
git clone https://github.com/containernet/containernet.git
cd containernet/ansible
sudo ansible-playbook -i 'localhost,' -c local install.yml
cd ..
sudo make develop

# clone CDCI labs and build containers
cd /home/student
git clone https://github.com/cs-pub-ro/CDCI-labs.git
cd CDCI-labs/containers
make
