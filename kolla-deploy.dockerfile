FROM python:3.8
LABEL Remarks="Dockerfile for kolla-ansible deploy"
ENV container docker

RUN pip3.8 install --upgrade pip \
    && pip3.8 install -U 'ansible==2.10.7' \
    && pip3.8 install 'openstacksdk==0.59.0' \
    && RUN pip3.8 install 'pyvmomi==7.0.3' \
    && RUN pip3.8 install git+https://opendev.org/openstack/kolla-ansible@stable/xena

ENV HOME /root
WORKDIR /root
EXPOSE 80
EXPOSE 443
EXPOSE 8004
CMD ["/usr/sbin/init"]