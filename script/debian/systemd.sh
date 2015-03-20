#!/bin/sh

# Sometimes this goes to fast...
sudo sed -i '/GRUB_HIDDEN_TIMEOUT/ s/^/#/' /etc/default/grub

# Change to vivid
sudo cp /etc/apt/source.list /etc/apt/source.list-OLD

sudo sed -i 's/trusty/vivid/g' /etc/apt/sources.list

# Update and upgrade
apt-get -y update
apt-get -y dist-upgrade
apt-get install -y  software-properties-common


# Install systemd
apt-get install -y systemd libpam-systemd systemd-ui

# Change the init to uuse it.

#GRUB_CMDLINE_LINUX_DEFAULT="quiet splash init=/lib/systemd/systemd"
