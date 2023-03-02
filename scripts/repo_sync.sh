#!/bin/bash

export repo_date=2023_02
mkdir -p /data/repos/$repo_date/8-stream

reposync -p /data/repos/$repo_date/centos/8-stream/ --download-metadata --repo=appstream
reposync -p /data/repos/$repo_date/centos/8-stream/ --download-metadata --repo=baseos
reposync -p /data/repos/$repo_date/centos/8-stream/ --download-metadata --repo=extras
reposync -p /data/repos/$repo_date/centos/8-stream/ --download-metadata --repo=powertools

reposync -p /data/repos/$repo_date/docker/ --download-metadata --repo=docker-ce-stable 

reposync -p /data/repos/$repo_date/centos/8/ --download-metadata --repo=centos-advanced-virtualization                                                           
reposync -p /data/repos/$repo_date/centos/8/ --download-metadata --repo=centos-ceph-pacific                                                                      
reposync -p /data/repos/$repo_date/centos/8/ --download-metadata --repo=centos-nfv-openvswitch                                                                   
reposync -p /data/repos/$repo_date/centos/8/ --download-metadata --repo=centos-openstack-xena                                                                    
reposync -p /data/repos/$repo_date/centos/8/ --download-metadata --repo=centos-rabbitmq-38                                                                           

reposync -p /data/repos/$repo_date/centos/8/ --repo=epel
reposync -p /data/repos/$repo_date/centos/8/ --repo=epel-modular 

## create repo metadata
createrepo /data/repos/$repo_date/centos/8-stream/appstream
createrepo /data/repos/$repo_date/centos/8-stream/baseos/
createrepo /data/repos/$repo_date/centos/8-stream/extras/ 
createrepo /data/repos/$repo_date/centos/8-stream/powertools/ 

createrepo /data/repos/$repo_date/docker/docker-ce-stable

createrepo /data/repos/$repo_date/centos/8/centos-advanced-virtualization 
createrepo /data/repos/$repo_date/centos/8/centos-ceph-pacific            
createrepo /data/repos/$repo_date/centos/8/centos-nfv-openvswitch         
createrepo /data/repos/$repo_date/centos/8/centos-openstack-xena          
createrepo /data/repos/$repo_date/centos/8/centos-rabbitmq-38      

createrepo /data/repos/$repo_date/centos/8/epel
createrepo /data/repos/$repo_date/centos/8/epel-modular

