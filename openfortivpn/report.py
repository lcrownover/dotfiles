#!/usr/bin/env python3

import urllib3
urllib3.disable_warnings()

from config import USERNAME,PASSWORD

import requests
import json
import subprocess

def runner(command):
    return subprocess.run(command, shell=True, stdout=subprocess.PIPE).stdout.strip()

primary_ip = "184.171.107.143"

num_nics = runner("ip addr | grep UP | wc -l")

if str(num_nics) == "3":
    # vpn is active
    ip_addr = runner("ip addr show dev ppp0 | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1")
else:
    ip_addr = primary_ip

payload = {"ip": ip_addr}

r = requests.post(
    "https://sas-api.uoregon.edu/api/v1/lcrown/eitri",
    json=payload,
    auth=(USERNAME,PASSWORD),
    verify=False,
)

out = json.loads(r.text)

if out['status'] == "success":
    exit(0)
exit(1)
