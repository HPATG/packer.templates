#!/bin/sh
# Copyright (c) 2013 Tech-Angels Inc.
# 
# MIT License
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#  https://github.com/jose-lpa/packer-debian_7.6.0/blob/1.0/scripts/virtualbox.sh
#
if test -f .vbox_version ; then
  # The netboot installs the VirtualBox support (old) so we have to remove it
  if test -f /etc/init.d/virtualbox-ose-guest-utils ; then
    /etc/init.d/virtualbox-ose-guest-utils stop
  fi

  rmmod vboxguest
  aptitude -y purge virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms virtualbox-ose-guest-utils

  # Install dkms for dynamic compiles
  apt-get install -y dkms

  # If libdbus is not installed, virtualbox will not autostart
  apt-get -y install --no-install-recommends libdbus-1-3

  # Install the VirtualBox guest additions
  mount -o loop VBoxGuestAdditions.iso /mnt
  yes|sh /mnt/VBoxLinuxAdditions.run
  umount /mnt
  rm -f VBoxLinuxAdditions.iso

  # Start the newly build driver
  /etc/init.d/vboxadd start
else
  # Dirty way to make this work...
  mkdir -p /mnt/virtualbox
  mount -o loop /home/vagrant/VBoxGuest*.iso /mnt/virtualbox
  sh /mnt/virtualbox/VBoxLinuxAdditions.run force
  umount /mnt/virtualbox
  rm -rf /home/vagrant/VBoxGuest*.iso
fi
