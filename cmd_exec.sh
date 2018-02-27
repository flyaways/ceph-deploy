#!/usr/bin/env bash
# MAINTAINER flyaways "meagleglass@gmail.com"

docker_run(){
   eval "docker -H $ip:${Machine[port_docker]} run $opt ${Machine[registry]}:${Machine[port_registry]}/$image $cmd $arg"
   #echo "docker -H $ip:${Machine[port_docker]} run $opt ${Machine[registry]}:${Machine[port_registry]}/$image $cmd $arg"
   echo "run $cmd@$ip"
}

docker_cmd(){
   eval "docker -H $ip:${Machine[port_docker]} $opt $arg"
   echo "docker -H $ip:${Machine[port_docker]} $opt $arg"
}