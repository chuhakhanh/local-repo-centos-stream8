# local-repo

## references
https://access.redhat.com/solutions/23016

## Configure storage

sudo parted -s -a optimal -- /dev/sdb mklabel gpt
sudo parted -s -a optimal -- /dev/sdb mkpart primary 0% 100%
sudo parted -s -- /dev/sdb align-check optimal 1
sudo pvcreate /dev/sdb1
sudo vgcreate data /dev/sdb1
sudo lvcreate -n repos -l+100%FREE data
sudo mkfs.xfs /dev/mapper/data-repos

mkdir /data
sudo vim /etc/fstab
/dev/mapper/data-repos /data xfs defaults 0 0 

sudo mount -a
cp conf/httpd.conf /etc/httpd/conf/httpd.conf

mkdir /data/repos/images

