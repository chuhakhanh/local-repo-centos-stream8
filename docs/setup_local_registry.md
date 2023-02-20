# Introduction
## References
  
  https://www.cnblogs.com/weiwei2021/p/14611055.html
  
# Deploy registry
Registry contains images. 
In this setup, images is used for Openstack installation with Kolla ansible version Xena

## Configure storage

  sudo dnf install python3-pip
  sudo dnf install python3-devel libffi-devel gcc openssl-devel python3-libselinux
  pip3 install 'ansible==2.10.7'
  pip3 install git+https://opendev.org/openstack/kolla-ansible@stable/xena
  cp -r /usr/local/share/kolla-ansible/etc_examples/kolla/ /etc/

  docker run -d -p 4000:5000 --restart=always --name registry -v /data/registry:/var/lib/registry registry:2

## Configure Kolla Ansible Images version Xena

### Provisioning images from images_openstack_xena list and registry repo-1:4000

  chmod u+x scripts/images_provisioning.sh
  scripts/images_provisioning.sh config/images_openstack_xena repo-1:4000


### Provisioning specific images to registry repo-1:4000

  export repo_url=repo-1:4000

  for line in openstack.kolla/centos-source-ceilometer-compute:xena openstack.kolla/centos-source-ceilometer-central:xena openstack.kolla/entos-source-ceilometer-notification:xena
  do
      docker pull quay.io/$line
      docker tag quay.io/$line $repo_url/$line
      docker push $repo_url/$line
  done
  
  for line in openstack.kolla/centos-source-cinder-backup:xena
  do
      docker pull quay.io/$line
      docker tag quay.io/$line $repo_url/$line
      docker push $repo_url/$line
  done

  for line in openstack.kolla/centos-source-kolla-toolbox:xena openstack.kolla/centos-source-cron:xena
  do
      docker pull quay.io/$line
      docker tag quay.io/$line $repo_url/$line
      docker push $repo_url/$line
  done
  
Check images list in registry

  curl -X GET http://repo-1:4000/v2/_catalog | jq -r 

Create deployment docker for Xena

  docker build -t kolla-deploy:xena --force-rm -f config/kolla-deploy.dockerfile .

## Configure for client

  mv /etc/systemd/system/docker.service /etc/systemd/system/docker.service_save
  vi /etc/sysconfig/docker
  vi /etc/docker/daemon.json
  {
  "insecure-registries" : ["repo-1:4000"]
  }

  {
  "bridge": "none",
  "insecure-registries" : ["repo-1:4000"],
  "ip-forward": false,
  "iptables": false,
  "log-opts": {
  "max-file": "5",
  "max-size": "50m"
  }
  }


  curl -sSL https://get.docker.io | bash
  echo 'INSECURE_REGISTRY="--insecure-registry repo-1:4000"' > /etc/sysconfig/docker

  tee /etc/systemd/system/docker.service <<-'EOF'
  # CentOS
  [Service]
  MountFlags=shared
  EnvironmentFile=/etc/sysconfig/docker
  ExecStart=/usr/bin/docker daemon $INSECURE_REGISTRY
  EOF

  systemctl daemon-reload
  systemctl restart docker


## On deploy server

  docker run -d --name deploy-1 kolla-deploy:xena 