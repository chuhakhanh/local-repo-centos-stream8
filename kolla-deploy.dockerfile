FROM centos:8
MAINTAINER SVTECH_CLOUD_TEAM
LABEL Remarks="Dockerfile base on Centos 8"
ENV container docker
# Pre-Process
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
FROM centos:centos8-stream
# Install Package
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum install epel-release -y
RUN dnf install 'dnf-command(config-manager)' -y
RUN dnf update -y
RUN dnf install python38 -y
RUN dnf install python3-devel -y
RUN pip3.8 install --upgrade pip
RUN pip3.8 install -U 'ansible==2.10.7' 
RUN pip3.8 install pyvmomi
RUN pip3.8 install kolla-ansible
RUN pip3.8 install 'openstacksdk==0.59.0'

ENV HOME /root
WORKDIR /root
EXPOSE 80
EXPOSE 443
EXPOSE 8004
CMD ["/usr/sbin/init"]