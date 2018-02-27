#!/usr/bin/env bash
#MAINTAINER flyaways "meagleglass@gmail.com"

run_consul(){
    local image="${Machine[image_consul]}:${Machine[tag_consul]}"
    for ip in ${Conscy[consul]}
    do
        local opt="-d --restart always --name=consul \
        -p 18300:8300 \
        -p 18301:8301 \
        -p 18301:8301/udp \
        -p 18302:8302 \
        -p 18302:8302/udp \
        -p 18400:8400 \
        -p 18500:8500 \
        -p 153:53/udp"
        local cmd="agent"
        local arg="-server -advertise $ip -join $Consul_master"
        docker_run
    done
}