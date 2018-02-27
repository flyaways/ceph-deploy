#!/usr/bin/env bash
# MAINTAINER flyaways "meagleglass@gmail.com"

run_mon(){
    local image="${Machine[image_ceph_daemon]}:${Machine[tag_ceph_daemon]}"
    for ip in ${Machine[mon]}
    do
        local opt="-d --restart=always --name=mon --net=host \
        -v /var/lib/ceph:/var/lib/ceph \
        -e MON_IP=$ip \
        -e CEPH_PUBLIC_NETWORK=${Machine[public_network]} \
        -e KV_TYPE=${Machine[KV_TYPE]} \
        -e KV_PORT=${Machine[KV_PORT]} \
        -e KV_IP=${Machine[KV_IP]}"
        local cmd="mon"
        local arg=""
        docker_run
    done
}