#!/usr/bin/env bash
# MAINTAINER flyaways "meagleglass@gmail.com"

#   ***********************************Machine Nodes***********************************
        node0=192.168.20.4      # for private registry
        node1=10.20.189.217     # for osd,mon,rgw,mds,restapi,rbd
        node2=10.20.189.218     # for osd,mon,etcd
        node3=10.20.189.219     # for osd,mon,remote_cgi

#   ***********************************Images******************************************
#   https://github.com/coreos/etcd.git

#   https://github.com/ceph/ceph-docker.git
#   https://store.docker.com/community/images/ceph/daemon

#   ***********************************Ceph Conf***************************************


        declare -A Conscy=([etcd]="$node2" \
                [port_etcd]=2379 \
                [etcd_master]=$node2 \
                [image_etcd]=coreos-etcd \
                [tag_etcd]=3.0 \
                [consul]="$node1 $node2 $node3" \
                [port_consul]=18500 \
                [consul_master]=$node1 \
                [image_consul]=consul \
                [tag_consul]=latest)

        declare -A Machine=([registry]="$node0" \
                [mon]="$node1 $node2 $node3" \
                [osd]="$node1 $node2 $node3" \
                [rgw]="$node1" \
                [mds]="$node1" \
                [restapi]="$node1" \
                [rbd]="$node1" \
                [remote_cgi]="$node3" \
                [$node1]="/dev/sdc" \
                [$node2]="/dev/sdc" \
                [$node3]="/dev/sdc" \
                [KV_TYPE]=etcd \
                [KV_IP]=${Conscy[etcd_master]} \
                [KV_PORT]=${Conscy[port_etcd]} \
                [port_remote_cgi]=9999 \
                [port_restapi]=9998 \
                [port_civetweb]=8888 \
                [port_docker]=2375 \
                [port_registry]=5000 \
                [public_network]=10.20.189.0/24 \
                [private_network]=192.168.20.0/24 \
                [image_ceph_daemon]=ceph-daemon \
                [tag_ceph_daemon]=tag-build-master-jewel-ubuntu-14.04)