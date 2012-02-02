#!/bin/sh

# Reassemble RAID1 after moving from one computer to another

mdadm --assemble /dev/md0 /dev/sda1 /dev/sdb1
mdadm --assemble --scan

mkdir /mnt/media
mount /dev/md0 /mnt/media

echo '/dev/md0        /mnt/media           auto    defaults        0       0' >> /etc/fstab
