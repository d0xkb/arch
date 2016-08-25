#!/bin/bash

#UPDATE first
pacman -Syu --noconfirm

#SOFTWARE installation
packages="chromium evince openssh transmission-gtk gvfs gvfs-smb mlocate bash-completion pkgstats arch-wiki-lite hdparm chrony"
utils="iotop htop rsync wavemon wget bc"
graphics="ristretto gimp"
media="qt4 vlc python-pip"
goodies="xfce4-cpugraph-plugin xfce4-netload-plugin xfce4-screenshooter xfce4-weather-plugin mousepad"
network="wicd wicd-gtk"
compress="zip unzip unrar p7zip lzop cpio"

pacman -S --noconfirm $packages $utils $graphics $media $goodies $network $compress
pacman -Sc --noconfirm && pacman-optimize
pip install livestreamer

#SUBMIT info about installed packages
pkgstats -q

#THINKPAD ACPI enable
echo "options thinkpad_acpi fan_control=1" > /etc/modprobe.d/thinkpad_acpi.conf

#PROFILE customizations
echo "source /root/.bashrc" >> /etc/profile
source /root/.bashrc

cat > /root/.bashrc <<EOF
#unlimited history length
HISTSIZE=
HISTFILESIZE=
#simple list alias
alias ll='ls -la --color=auto'
EOF

#SYSTEMD tuning
echo "DefaultTimeoutStartSec=10s" >> /etc/systemd/system.conf
echo "DefaultTimeoutStopSec=10s" >> /etc/systemd/system.conf

#TIME/NTP config
timedatectl set-ntp false
timedatectl set-timezone Europe/Prague

cat > /etc/chrony.conf <<EOF
server ntp.nic.cz prefer iburst
server tik.cesnet.cz iburst
server tak.cesnet.cz iburst
driftfile /etc/chrony.drift
deny all
rtconutc
rtcsync
EOF

#SERVICES modifications
systemctl enable wicd
systemctl enable chrony.service
