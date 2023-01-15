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

  chmod u+x scripts/images_provisioing.sh
  scripts/images_provisioing.sh config/images_openstack_xena repo-1:4000

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

## On new client

  curl -X GET http://repo-1:4000/v2/_catalog | jq -r 
  docker pull repo-1:4000/openstack.kolla/centos-source-mariadb-server:xena

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


  docker pull repo-1:4000/centos-source-cinder-api:xena


## Create deployment docker for Xena

  docker build -t kolla-deploy:xena --force-rm -f kolla-deploy.dockerfile .
  docker run -d --name deploy-1 kolla-deploy:xena 