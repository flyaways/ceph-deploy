#!/usr/bin/env bash
# MAINTAINER flyaways "meagleglass@gmail.com"

run_restapi(){  
    local image="${Machine[image_ceph_daemon]}:${Machine[tag_ceph_daemon]}"
    for ip in ${Machine[restapi]}
    do
        local opt="-d --restart=always --name=restapi --net=host \
        -e RESTAPI_PORT=${Machine[port_restapi]} \
        -e KV_TYPE=${Machine[KV_TYPE]} \
        -e KV_PORT=${Machine[KV_PORT]} \
        -e KV_IP=${Machine[KV_IP]}"
        local cmd="restapi"
        local arg=""
        docker_run
    done
}