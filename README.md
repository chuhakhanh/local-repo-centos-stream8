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

mkdir -p /data/repos/2022_03/8-stream



##	Repo list
### Centos 8 Stream Repos
appstream                                                                                                      CentOS Stream 8 - AppStream
baseos                                                                                                         CentOS Stream 8 - BaseOS
docker                                                                                                         Docker main Repository
docker-ce-stable                                                                                               Docker CE Stable - x86_64
extras      

### Openstack Xena Repos
centos-advanced-virtualization                                                                                 CentOS-8 - Advanced Virtualization
centos-ceph-pacific                                                                                            CentOS-8-stream - Ceph Pacific
centos-nfv-openvswitch                                                                                         CentOS-8 - NFV OpenvSwitch
centos-openstack-xena                                                                                          CentOS-8 - OpenStack xena
centos-rabbitmq-38                                                                                             CentOS-8 - RabbitMQ 38

## sync repo data
reposync -p /data/repos/2022_03/centos/8-stream/ --download-metadata --repo=appstream
reposync -p /data/repos/2022_03/centos/8-stream/ --download-metadata --repo=baseos
reposync -p /data/repos/2022_03/centos/8-stream/ --download-metadata --repo=docker-ce-stable 
reposync -p /data/repos/2022_03/centos/8-stream/ --download-metadata --repo=extras
reposync -p /data/repos/2022_03/centos/8-stream/ --download-metadata --repo=powertools

reposync -p /data/repos/2022_03/centos/8/ --download-metadata --repo=centos-advanced-virtualization                                                           
reposync -p /data/repos/2022_03/centos/8/ --download-metadata --repo=centos-ceph-pacific                                                                      
reposync -p /data/repos/2022_03/centos/8/ --download-metadata --repo=centos-nfv-openvswitch                                                                   
reposync -p /data/repos/2022_03/centos/8/ --download-metadata --repo=centos-openstack-xena                                                                    
reposync -p /data/repos/2022_03/centos/8/ --download-metadata --repo=centos-rabbitmq-38                                                                           
                                                                       

## create repo metadata
createrepo -v /data/repos/2022_03/centos/8-stream/appstream
createrepo -v /data/repos/2022_03/centos/8-stream/baseos/
createrepo -v /data/repos/2022_03/centos/8-stream/docker-ce-stable
createrepo -v /data/repos/2022_03/centos/8-stream/extras/ 
createrepo -v /data/repos/2022_03/centos/8-stream/powertools/ 

createrepo -v /data/repos/2022_03/centos/8/centos-advanced-virtualization 
createrepo -v /data/repos/2022_03/centos/8/centos-ceph-pacific            
createrepo -v /data/repos/2022_03/centos/8/centos-nfv-openvswitch         
createrepo -v /data/repos/2022_03/centos/8/centos-openstack-xena          
createrepo -v /data/repos/2022_03/centos/8/centos-rabbitmq-38      



$ sudo dnf update -y
$ sudo dnf config-manager --enable powertools
$ sudo dnf install -y centos-release-openstack-xena
$ sudo dnf update -y
$ sudo dnf install -y openstack-packstack
$ sudo packstack --allinone