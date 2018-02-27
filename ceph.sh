#!/usr/bin/env bash
# MAINTAINER flyaways "meagleglass@gmail.com"

. conf.sh
. cmd_exec.sh

. etcd.sh
. consul.sh
. mon.sh
. osd.sh
. rgw.sh
. mds.sh
. rbd.sh
. restapi.sh
. admin.sh

ceph_role(){
    case $2 in
        all)
            run_etcd
            run_mon
            run_osd
            run_rgw
            sleep 10
            run_admin
            ;;
        etcd|mon|osd|rgw|admin)
            run_$2
            ;;
        *)
            usage
            exit 1
            ;;
    esac
}

ceph_ctl(){
    if [ $1 = "rm" ];then
        local opt="rm -f"
    else
        local opt=$1
    fi

    if [ $# -gt 0 ];then
    case $2 in
        all)
            ceph_ctl $1 etcd
            ceph_ctl $1 mon
            ceph_ctl $1 osd
            ceph_ctl $1 rgw
            ;;
        etcd|mon|osd|rgw)
            for ip in ${Machine[$2]}
            do
                docker_cmd
            done
            ;;
        *)
            usage
            exit 1
            ;;
    esac
    fi
}

main(){
    if [ $# -gt 0 ];then
    case $1 in
        run)
            ceph_role $@
            ;;
        start|stop|restart|rm)
            ceph_ctl $@
            ;;
        *)
            usage
            exit 1
            ;;
    esac
    fi
}

usage() {
    echo -e "\033[7;30;43m  *********************************************************************** \033[0m"
    echo -e "\033[7;30;47m  Examples:etcd,mon,osd,rgw,admin                                         \033[0m"
    echo -e "\033[7;30;43m  *********************************************************************** \033[0m"
    echo -e "\033[7;30;42m      \$sudo  echo    'hostname' /etc/hostname                            \033[0m"
    echo -e "\033[7;30;42m      \$sudo  rm  -rf /etc/ceph/* /var/lib/ceph/*                         \033[0m"
    echo -e "\033[7;30;42m      \$sudo  sysctl  -w  vm.max_map_count=655360 &&sudo sysctl   -p      \033[0m"
    echo -e "\033[7;30;42m      \$sudo  sysctl  -w  kernel.pid_max=4194303  &&sudo sysctl   -p      \033[0m"
    echo -e "\033[7;30;43m  *********************************************************************** \033[0m"
    echo -e "\033[7;30;42m      \$./ceph.sh   run       all                                         \033[0m"
    echo -e "\033[7;30;42m      \$./ceph.sh   run       rgw                                         \033[0m"
    echo -e "\033[7;30;42m      \$./ceph.sh   start     rgw                                         \033[0m"
    echo -e "\033[7;30;42m      \$./ceph.sh   stop      rgw                                         \033[0m"
    echo -e "\033[7;30;42m      \$./ceph.sh   restart   rgw                                         \033[0m"
    echo -e "\033[7;30;42m      \$./ceph.sh   rm        rgw                                         \033[0m"
    echo -e "\033[7;30;42m      \$./ceph.sh   run       admin                                       \033[0m"
    echo -e "\033[7;30;43m  *********************************************************************** \033[0m"
}

main $@