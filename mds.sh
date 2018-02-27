#!/usr/bin/env bash
# MAINTAINER flyaways "meagleglass@gmail.com"

run_mds(){  
    local image="${Machine[image_ceph_daemon]}:${Machine[tag_ceph_daemon]}"
    for ip in ${Machine[mds]}
    do
        local opt="-d --restart=always --name=mds --net=host \
        -e CEPHFS_CREATE=1 \
        -e KV_TYPE=${Machine[KV_TYPE]} \
        -e KV_PORT=${Machine[KV_PORT]} \
        -e KV_IP=${Machine[KV_IP]}"
        local cmd="mds"
        local arg=""
        docker_run
    done
}