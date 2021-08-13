#!/bin/bash

# This will install the ip report cron job

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

test -f report.py || (echo "You must run this script from where report.py is saved"; exit 1)

CRONFILE="ip_report"

cp -f $CRONFILE /etc/cron.d/$CRONFILE
sed -i "s|PATH|$(pwd)/report.py|g" /etc/cron.d/$CRONFILE
chmod 644 /etc/cron.d/$CRONFILE
chown root:root /etc/cron.d/$CRONFILE
