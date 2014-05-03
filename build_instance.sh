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
pacman -S grub --noconfirm
grub-install --force --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo Set Root Password....
passwd
echo Adding User
useradd -g users kent
echo Set User Password...
passwd kent
mkdir /home/kent
echo "kent ALL=(ALL) ALL" >> /etc/sudoers
pacman -S ttf-dejavu ttf-ubuntu-font-family ttf-droid reflector --noconfirm
cp -vf /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bkup
reflector --verbose -l 15 -p http -sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

echo "complete -cf sudo" >> /home/kent/.bashrc
echo "complete -cf man" >> /home/kent/.bashrc
# exit
