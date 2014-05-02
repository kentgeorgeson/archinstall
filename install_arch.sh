#!/bin/bash
setfont Lat2-Terminus16
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen
export LANG=en_US.UTF-8
systemctl start dhcpcd.service
sgdisk --zap-all /dev/sda
sfdisk /dev/sda << EOF
20,768,,*
,,,
;
;
EOF
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda2
mount /dev/sda1 /mnt
mkdir /mnt/home
mount /dev/sda2 /mnt/home
pacstrap -i /mnt base git vim --noconfirm
genfstab -U -p /mnt >> /mnt/etc/fstab
mkdir /mnt/home/root
cp build_instance.sh /mnt/home/root/
chmod 755 /mnt/home/root/build_instance.sh
arch-chroot /mnt /bin/bash
# umount -R /mnt
# reboot
