#!/usr/bin/bash

image_tag=xena

# delete images
#docker images | awk '{print $3}' | xargs docker rmi -f

# pull public images
for public_images in memcached kolla-toolbox cron mariadb rabbitmq keepalived haproxy chrony etcd
do
  docker pull kolla/centos-source-$public_images:$image_tag
done

# pull log manage images
for log_images in fluentd elasticsearch kibana
do
  docker pull kolla/centos-source-$log_images:$image_tag
done

# pull nova
for nova in nova-ssh nova-placement-api placement-api nova-api nova-consoleauth nova-serialproxy nova-scheduler nova-novncproxy nova-conductor nova-compute nova-libvirt
do
  docker pull kolla/centos-source-$nova:$image_tag
done

# pull keystone
for keystone in keystone-ssh keystone-fernet keystone
do
  docker pull kolla/centos-source-$keystone:$image_tag
done

# pull glance
docker pull kolla/centos-source-glance-api:$image_tag
docker pull kolla/centos-source-glance-registry:$image_tag

# pull cinder
for cinder in cinder-volume cinder-api cinder-backup cinder-scheduler
do
  docker pull kolla/centos-source-$cinder:$image_tag
done

# pull neutron
for neutron in neutron-server neutron-dhcp-agent neutron-l3-agent neutron-openvswitch-agent neutron-metadata-agent neutron-lbaas-agent neutron-sfc-agent neutron-bgp-dragent
do
  docker pull kolla/centos-source-$neutron:$image_tag
done

# pull openvswitch
docker pull kolla/centos-source-openvswitch-vswitchd:$image_tag
docker pull kolla/centos-source-openvswitch-db-server:$image_tag

# pull horizon
docker pull kolla/centos-source-horizon:$image_tag

# pull heat
for heat in heat-api heat-api-cfn heat-engine
do
  docker pull kolla/centos-source-$heat:$image_tag
done

# pull ceph
for ceph in ceph-mon ceph-osd ceph-mgr cephfs-fuse ceph-rgw ceph-mds
do
  docker pull kolla/centos-source-$ceph:$image_tag
done

# pull zun
for zun in zun-api zun-compute zun-wsproxy
do
  docker pull kolla/centos-source-$zun:$image_tag
done

# pull magnum
for magnum in magnum-api magnum-conductor
do
  docker pull kolla/centos-source-$magnum:$image_tag
done

# pull kuryr
docker pull kolla/centos-source-kuryr-libnetwork:$image_tag

# pull cloudkitty
for cloudkitty in cloudkitty-api cloudkitty-processor
do
  docker pull kolla/centos-source-$cloudkitty:$image_tag
done

# pull grafana influxdb telegraf
for monitor in grafana influxdb telegraf
do
  docker pull kolla/centos-source-$monitor:$image_tag
done

# pull mistral
for mistral in mistral-api mistral-engine mistral-executor mistral-event-engine
do
  docker pull kolla/centos-source-$mistral:$image_tag
done

# pull aodh
for aodh in aodh-api aodh-evaluator aodh-listener aodh-notifier
do
  docker pull kolla/centos-source-$aodh:$image_tag
done

# pull tempest
docker pull kolla/centos-source-tempest:$image_tag

# pull ceilometer
for ceilometer in ceilometer-compute ceilometer-central ceilometer-notification
do
  docker pull kolla/centos-source-$ceilometer:$image_tag
done

# pull gnocchi
for gnocchi in gnocchi-statsd gnocchi-metricd gnocchi-api
do
  docker pull kolla/centos-source-$gnocchi:$image_tag
done

# pull senlin
for senlin in senlin-engine senlin-api
do
  docker pull kolla/centos-source-$senlin:$image_tag
done

# pull manila
for manila in manila-data manila-share manila-scheduler manila-api
do
  docker pull kolla/centos-source-$manila:$image_tag
done

# pull trove
for trove in trove-taskmanager trove-conductor trove-api
do
  docker pull kolla/centos-source-$trove:$image_tag
done

# pull redis
for redis in redis redis-sentinel
do
  docker pull kolla/centos-source-$redis:$image_tag
done

# pull tacker
for tacker in tacker-server tacker-conductor
do
  docker pull kolla/centos-source-$tacker:$image_tag
done

# pull panko-api
docker pull kolla/centos-source-panko-api:$image_tag

# pull kafka
docker pull kolla/centos-source-kafka:$image_tag

# pull zookeeper
docker pull kolla/centos-source-zookeeper:$image_tag

# pull barbican
for barbican in barbican-api barbican-keystone-listener barbican-worker
do
  docker pull kolla/centos-source-$barbican:$image_tag
done

# pull freezer
for freezer in freezer-api freezer-scheduler
do
  docker pull kolla/centos-source-$freezer:$image_tag
done

# pull solum
for solum in solum-api solum-deployer solum-conductor solum-worker
do
  docker pull kolla/centos-source-$solum:$image_tag
done

# pull karbor
for karbor in karbor-api karbor-protection karbor-operationengine
do
  docker pull kolla/centos-source-$karbor:$image_tag
done

# pull searchlight
for searchlight in searchlight-api searchlight-listener
do
  docker pull kolla/centos-source-$searchlight:$image_tag
done
