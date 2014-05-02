#!/bin/bash
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo FONT=Lat2-Terminus16 > /etc/vconsole.conf
ln -s /user/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc --localtime
echo k2 > /etc/hostname
systemctl enable dhcpcd.service
pacman -S syslinux --noconfirm
syslinux-install_update -i -a -m
nano /boot/syslinux/syslinux.cfg

