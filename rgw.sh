#!/usr/bin/env bash
# MAINTAINER flyaways "meagleglass@gmail.com"

run_rgw(){
    #docker exec <containerId> radosgw-admin -n client.rgw.$(hostname) -k /var/lib/ceph/radosgw/$(hostname)/keyring <commands>
    local image="${Machine[image_ceph_daemon]}:${Machine[tag_ceph_daemon]}"
    for ip in ${Machine[rgw]}
    do
        local opt="-d --restart=always --name=rgw --net=host \
        -e RGW_CIVETWEB_PORT=${Machine[port_civetweb]} \
        -e RGW_NAME:$(hostname) \
        -e RGW_ZONEGROUP:empty \
        -e RGW_ZONE:empty \
        -e KV_TYPE=${Machine[KV_TYPE]} \
        -e KV_PORT=${Machine[KV_PORT]} \
        -e KV_IP=${Machine[KV_IP]}"
        local cmd="rgw"
        local arg=""
        local docker_run
    done
}

run_rgw_external_cgi(){
    #docker exec <containerId> radosgw-admin -n client.rgw.$(hostname) -k /var/lib/ceph/radosgw/$(hostname)/keyring <commands>
    local image="${Machine[image_ceph_daemon]}:${Machine[tag_ceph_daemon]}"
    for ip in ${Machine[rgw]}
    do
        local opt="-d --restart=always --name=rgw --net=host \
        -e RGW_REMOTE_CGI=1 \
        -e RGW_REMOTE_CGI_HOST=${Machine[remote_cgi]} \
        -e RGW_REMOTE_CGI_PORT=${Machine[port_remote_cgi]} \
        -e RGW_NAME:$(hostname) \
        -e RGW_ZONEGROUP:empty \
        -e RGW_ZONE:empty \
        -e KV_TYPE=${Machine[KV_TYPE]} \
        -e KV_PORT=${Machine[KV_PORT]} \
        -e KV_IP=${Machine[KV_IP]}"
        local cmd="rgw"
        local arg=""
        docker_run
    done
}