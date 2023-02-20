#!/bin/bash
parted -s -a optimal -- /dev/sdb mklabel gpt
parted -s -a optimal -- /dev/sdb mkpart primary 0% 100%
parted -s -- /dev/sdb align-check optimal 1
pvcreate /dev/sdb1
vgcreate data /dev/sdb1
lvcreate -n repos -l+100%FREE data
mkfs.xfs /dev/mapper/data-repos
mkdir /data
echo "/dev/mapper/data-repos /data xfs defaults 0 0" >> /etc/fstab
mount -a
