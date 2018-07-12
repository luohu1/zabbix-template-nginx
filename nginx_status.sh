#!/bin/bash
# Monitor nginx by zabbix
#
url="http://127.0.0.1/nginx_status?auto"
response="wget --quiet -O - ${url}"

case $1 in
    alived)
        curl -sL -w "%{http_code}" ${url} -o /dev/null
        ;;  
    active)
        $response | awk '/Active/{print $3}'
        ;;
    reading)
        $response | awk '/Reading/{print $2}'
        ;;
    writing)
        $response | awk '/Writing/{print $4}'
        ;;
    waiting)
        $response | awk '/Waiting/{print $6}'
        ;;
    accepts)
        $response | awk 'NR==3{print $1}'
        ;;
    handled)
        $response | awk 'NR==3{print $2}'
        ;;
    requests)
        $response | awk 'NR==3{print $3}'
        ;;
    *)
        echo -e "\e[031mUsage: $0 {alived|active|reading|writing|waiting|accepts|handled|requests}\e[0m"
        exit 1
esac