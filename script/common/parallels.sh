#!/bin/bash

#if [ $PACKER_BUILDER_TYPE = parallels*  ] 
apt-get install -y linux-headers-$(uname -r) build-essential

echo ################################
echo ################################
echo ################################
echo ################################
echo ################################

mount -r -t iso9660 /dev/cdrom /mnt
/mnt/install --install-unattended --progress

echo ################################
echo ################################
echo ################################
echo ################################
echo ################################

cat /var/log/parallels-tools-install.log

umount /mnt
