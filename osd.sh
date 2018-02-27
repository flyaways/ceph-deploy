#!/usr/bin/env bash
# MAINTAINER flyaways "meagleglass@gmail.com"

run_osd(){
    local image="${Machine[image_ceph_daemon]}:${Machine[tag_ceph_daemon]}"
    for ip in ${Machine[osd]}
    do
        local opt="--rm --privileged=true --name=zap_osd \
        -v /dev/:/dev/ \
        -e OSD_DEVICE=${Machine[$ip]}"
        local cmd="zap_device"
        local arg=""
        docker_run

        local opt="rm -f zap_osd"
        #docker_cmd

        local opt="-d --restart=always  --name=osd --net=host \
        --privileged=true \
        --pid=host \
        -v /dev/:/dev/ \
        -e OSD_DEVICE=${Machine[$ip]} \
        -e OSD_FORCE_ZAP=1 \
        -e KV_TYPE=${Machine[KV_TYPE]} \
        -e KV_PORT=${Machine[KV_PORT]} \
        -e KV_IP=${Machine[KV_IP]}"
        local cmd="osd"
        local arg=""
        docker_run
     done
}