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
reposync -p /data/repos/2022_03/centos/8-stream/ --download-metadata --repo=extras
reposync -p /data/repos/2022_03/centos/8-stream/ --download-metadata --repo=powertools

reposync -p /data/repos/2022_03/docker/ --download-metadata --repo=docker-ce-stable 
reposync -p /data/repos/2022_03/docker/ --repo=docker

reposync -p /data/repos/2022_03/centos/8/ --download-metadata --repo=centos-advanced-virtualization                                                           
reposync -p /data/repos/2022_03/centos/8/ --download-metadata --repo=centos-ceph-pacific                                                                      
reposync -p /data/repos/2022_03/centos/8/ --download-metadata --repo=centos-nfv-openvswitch                                                                   
reposync -p /data/repos/2022_03/centos/8/ --download-metadata --repo=centos-openstack-xena                                                                    
reposync -p /data/repos/2022_03/centos/8/ --download-metadata --repo=centos-rabbitmq-38                                                                           

reposync -p /data/repos/2022_03/centos/8/ --repo=epel
reposync -p /data/repos/2022_03/centos/8/ --repo=epel-modular 
                                                                       

## create repo metadata
createrepo -v /data/repos/2022_03/centos/8-stream/appstream
createrepo -v /data/repos/2022_03/centos/8-stream/baseos/
createrepo -v /data/repos/2022_03/centos/8-stream/extras/ 
createrepo -v /data/repos/2022_03/centos/8-stream/powertools/ 

createrepo -v /data/repos/2022_03/docker/docker-ce-stable
createrepo -v /data/repos/2022_03/docker/docker

createrepo -v /data/repos/2022_03/centos/8/centos-advanced-virtualization 
createrepo -v /data/repos/2022_03/centos/8/centos-ceph-pacific            
createrepo -v /data/repos/2022_03/centos/8/centos-nfv-openvswitch         
createrepo -v /data/repos/2022_03/centos/8/centos-openstack-xena          
createrepo -v /data/repos/2022_03/centos/8/centos-rabbitmq-38      

createrepo -v /data/repos/2022_03/centos/8/epel
createrepo -v /data/repos/2022_03/centos/8/epel-modular