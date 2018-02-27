#!/usr/bin/env bash
# MAINTAINER flyaways "meagleglass@gmail.com"

ceph_radosgw-admin(){
    local RGW_RESPONSE=$(docker -H $ip:${Machine[port_docker]} exec rgw radosgw-admin user create --uid=$uuid --display-name=$uuid)
    ACCESS_KEY=$(echo "$RGW_RESPONSE" | sed -n 's/ *"access_key": "\(.*\)",/\1/p')
    SECRET_KEY=$(echo "$RGW_RESPONSE" | sed -n 's/ *"secret_key": "\(.*\)"/\1/p')
    CEPH_CRATE=$(date)
}

run_admin(){
    for ip in ${Machine[rgw]}
    do
        #uuid=$(uuidgen)
        local uuid=wpsep
        ceph_radosgw-admin
        echo "CEPH_KEY_BIRTH=$CEPH_CRATE"       >> key.conf
        echo "CEPH_KEY_UID=$uuid"               >> key.conf
        echo "CEPH_ACCESSKEY=$ACCESS_KEY"       >> key.conf
        echo "CEPH_SECRETKEY=$SECRET_KEY"       >> key.conf
        echo ""                                 >> key.conf
        echo ""
        echo -e "\033[7;30;43m  CEPH_UID=$uuid              \033[0m"
        echo -e "\033[7;30;43m  CEPH_ACCESSKEY=$ACCESS_KEY  \033[0m"
        echo -e "\033[7;30;43m  CEPH_SECRETKEY=$SECRET_KEY  \033[0m"
        echo ""
    done
}
