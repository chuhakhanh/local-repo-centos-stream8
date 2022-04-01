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



$ sudo dnf update -y
$ sudo dnf config-manager --enable powertools
$ sudo dnf install -y centos-release-openstack-xena
$ sudo dnf update -y
$ sudo dnf install -y openstack-packstack
$ sudo packstack --allinone

cp conf/httpd.conf /etc/httpd/conf/httpd.conf

docker build -t kolla-deploy:xena --force-rm -f kolla-deploy.dockerfile .
docker run -d --name deploy-1 kolla-deploy:xena 
docker run -d -p 4000:5000 --restart=always --name registry -v /data/registry:/var/lib/registry registry:2