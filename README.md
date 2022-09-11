# local-repo

This guide to setup a local repository for centos-stream-8
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

/data/registry: for local registry
/data/repos: for local repository
/data/harbor: for local harbor
## Setup
### Setup local repository
[Following steps in docs/setup_local_quay.md to setup a local quay](docs/setup_local_registry.md)
### Setup quayio
[Following steps in docs/setup_local_yum_repository.md to setup a local repository](docs/setup_local_yum_repository.md)

## Client
### On deploy node configure docker repo to repo-1 and download deloyment docker


### remove podman and install docker-ce
yum remove buildah skopeo podman containers-common atomic-registries docker container-tools
yum install docker-ce; systemctl start docker; systemctl enable docker
vi /etc/docker/daemon.json
{
  "insecure-registries" : ["repo-1:4000"]
}
systemctl restart docker

docker pull repo-1:4000/openstack.kolla/centos-source-deploy:xena
docker run -d --name deploy-1 repo-1:4000/openstack.kolla/centos-source-deploy:xena
docker exec -it deploy-1 /bin/bash; 
vi ~/.bashrc 
alias ll='ls -lG'


