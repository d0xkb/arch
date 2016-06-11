#!/bin/bash

#
#thunar installation
#

thunar="https://archive.archlinux.org/packages/t/thunar/thunar-1.6.6-2-x86_64.pkg.tar.xz"
pkg="/var/cache/pacman/pkg/"

wget -q $thunar -P $pkg
pacman -q -U --noconfirm $pkg/thunar-1.6.6-2-x86_64.pkg.tar.xz
sed -i '/^#IgnorePkg/s/#IgnorePkg   =/IgnorePkg   =	thunar/' /etc/pacman.conf