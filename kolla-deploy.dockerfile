FROM python:3.9
MAINTAINER SVTECH_CLOUD_TEAM
LABEL Remarks="Dockerfile for kolla-ansible deploy"
ENV container docker

RUN pip3.8 install --upgrade pip
RUN pip3.8 install -U 'ansible==2.10.7' 
RUN pip3.8 install 'openstacksdk==0.59.0'
RUN pip3.8 install 'pyvmomi==7.0.3'
RUN pip3.8 install 'kolla-ansible==13.0.2.dev92'

ENV HOME /root
WORKDIR /root
EXPOSE 80
EXPOSE 443
EXPOSE 8004
CMD ["/usr/sbin/init"]