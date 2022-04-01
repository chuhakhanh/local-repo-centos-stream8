FROM centos:8
LABEL Remarks="Dockerfile for kolla-ansible deploy"
ENV container docker

# Prepare environment
RUN cd /lib/systemd/system/sysinit.target.wants/ \
    && for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done \
    && rm -f /lib/systemd/system/multi-user.target.wants/* \
    && rm -f /etc/systemd/system/*.wants/* \
    && rm -f /lib/systemd/system/local-fs.target.wants/* \
    && rm -f /lib/systemd/system/sockets.target.wants/*udev* \
    && rm -f /lib/systemd/system/sockets.target.wants/*initctl* \
    && rm -f /lib/systemd/system/basic.target.wants/* \
    && rm -f /lib/systemd/system/anaconda.target.wants/*

# Install Package
RUN cd /etc/yum.repos.d/ \
    && sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
    && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* \
    && yum install epel-release -y \
    && dnf install 'dnf-command(config-manager)' -y \
    && dnf update -y \
    && dnf install python38 -y \
    && dnf install python38-devel -y \
    && pip3.8 install --upgrade pip \
    && pip3.8 install -U 'ansible==2.10.7' \
    && pip3.8 install 'openstacksdk==0.59.0' \
    && pip3.8 install 'pyvmomi==7.0.3' \
    && yum install git -y \
    && pip3.8 install git+https://opendev.org/openstack/kolla-ansible@stable/xena \
    && pip3.8 install python-openstackclient -c https://releases.openstack.org/constraints/upper/xena

VOLUME [ "/sys/fs/cgroup" ]
ENV HOME /root
WORKDIR /root
CMD ["/usr/sbin/init"]

