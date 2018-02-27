#!/usr/bin/env bash
# MAINTAINER flyaways "meagleglass@gmail.com"

run_etcd(){
    local image="${Machine[image_etcd]}:${Machine[tag_etcd]}"
    local ip=${Machine[etcd]}
    local opt="-d --restart=always --name=etcd \
    -p 2380:2380 \
    -p ${Machine[port_etcd]}:2379"
    local cmd="/usr/local/bin/etcd"
    local arg="-name etcd0 \
    -advertise-client-urls http://$ip:2379 \
    -listen-client-urls http://0.0.0.0:2379 \
    -initial-advertise-peer-urls http://$ip:2380 \
    -listen-peer-urls http://0.0.0.0:2380 \
    -initial-cluster-token etcd-cluster-1 \
    -initial-cluster etcd0=http://$ip:2380 \
    -initial-cluster-state new"
    docker_run
}

#add members
# etcdctl member add node2 http://10.211.55.12:2380