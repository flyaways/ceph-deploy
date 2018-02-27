#!/usr/bin/env bash
# MAINTAINER flyaways "meagleglass@gmail.com"

run_rbd(){  
    local image="${Machine[image_ceph_daemon]}:${Machine[tag_ceph_daemon]}"
    for ip in ${Machine[rbd]}
    do
        local opt="-d --restart=always --name=rbd_mirror --net=host \
        -e KV_TYPE=${Machine[KV_TYPE]} \
        -e KV_PORT=${Machine[KV_PORT]} \
        -e KV_IP=${Machine[KV_IP]}"
        local cmd="rbd_mirror"
        local arg=""
        docker_run
    done
}