#!/bin/bash
setfont Lat2-Terminus16
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen
export LANG=en_US.UTF-8
systemctl start dhcpcd.service
sgdisk --zap-all /dev/sda
sfdisk /dev/sda << EOF
0,768,,*
,,,
;
;
EOF
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda2
mount /dev/sda1 /mnt
mkdir /mnt/home
mount /dev/sda2 /mnt/home
pacstrap -i /mnt base
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash


echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo FONT=Lat2-Terminus16 > /etc/vconsole.conf
ln -s /user/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc --localtime
echo k2 > /etc/hostname
systemctl enable dhcpcd.service
pacman -S grub
grub-install --target=i386-pc --recheck /dev/sda1
grub-mkconfig -o /boot/grub/grub.conf
exit

umount -R /mnt
reboot
