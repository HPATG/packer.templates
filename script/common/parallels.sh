#!/bin/bash

#if [ $PACKER_BUILDER_TYPE = parallels*  ] 
apt-get install -y linux-headers-$(uname -r) build-essential

mount -r -t iso9660 /dev/cdrom /mnt
/mnt/install --install-unattended --progress

cat /var/log/parallels-tools-install.log

umount /mnt
