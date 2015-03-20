#!/bin/sh

# Upgrade the box
sed -i  -e 's/wheezy/jessie/g' /etc/apt/sources.list
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade

# Install dependencies
apt-get -y install linux-headers-$(uname -r) build-essential
apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev
apt-get -y install curl unzip
apt-get -y install dkms
apt-get -y install nfs-common
#apt-get -y install cloud-init 
#cloud-tools cloud-initiramfs-growroot cloud-initramfs-tools cloud-initramfs-dyn-netconf

