## Setup httpd
yum install httpd
cp conf/httpd.conf /etc/httpd/conf/httpd.conf
mkdir /data/repos/images

##	Repo list

dnf install -y centos-release-openstack-xena

Centos 8 Stream Repos

| Software | Version |
| --- | --- |
| `appstream` | *CentOS Stream 8 - AppStream* |
| `baseos` | * CentOS Stream 8 - BaseOS* |
| `docker` | * Docker main Repository* |
| `docker-ce-stable  ` | * Docker CE Stable - x86_64* |
| `extras` | * CentOS Stream 8 - Extras* |

Openstack Xena Repos
| Software | Version |
| --- | --- |
| `centos-advanced-virtualization` | *CentOS-8 - Advanced Virtualization* |
| `centos-ceph-pacific` | *CentOS-8-stream - Ceph Pacific* |
| `centos-nfv-openvswitch` | *CentOS-8 - NFV OpenvSwitch* |
| `centos-openstack-xena` | *CentOS-8 - OpenStack xena* |
| `centos-rabbitmq-38` | *CentOS-8 - RabbitMQ 38* |

### sync repo data

    scripts/repo_sync.sh > output.log & 
                                                                       




