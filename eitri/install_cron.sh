#!/bin/bash

# This will install the ip report cron job

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

test -f report.py || (echo "You must run this script from where report.py is saved"; exit 1)

sed -i "s|PATH|$(pwd)/report.py|g" ip_report.cron
cp -f ip_report.cron /etc/cron.d/ip_report.cron
