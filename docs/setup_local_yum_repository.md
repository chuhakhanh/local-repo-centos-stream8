## Setup httpd
yum install httpd
cp conf/httpd.conf /etc/httpd/conf/httpd.conf
mkdir /data/repos/images

##	Repo list

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

## Download repo

Prepare source

    dnf install -y centos-release-openstack-xena
    dnf install -y epel-release
    yum install createrepo

sync & createrepo 

    ./scripts/repo_sync.sh > output.log & 
    cd /data/repos/2023_02;  tree -L 3 .   
    .
    ├── centos
    │   ├── 8
    │   │   ├── centos-advanced-virtualization
    │   │   ├── centos-ceph-pacific
    │   │   ├── centos-nfv-openvswitch
    │   │   ├── centos-openstack-xena
    │   │   ├── centos-rabbitmq-38
    │   │   ├── epel
    │   │   └── epel-modular
    │   └── 8-stream
    │       ├── appstream
    │       ├── baseos
    │       ├── extras
    │       └── powertools
    └── docker
        └── docker-ce-stable
            ├── Packages
            └── repodata                                                   

Run docker httpd for repo

    docker pull httpd
    docker run -d -p 80:80 -v /data/repos/:/var/www/html --name httpd-repo httpd
    
