#!/usr/bin/env python3

import json
import sys

in_data = sys.stdin.readline()

try:
    j = json.loads(in_data.strip())
    print(j['ip'])
except Exception as e:
    print("failed to parse input")
    print(e)
