#!/usr/bin/env python3 
import sys

where = sys.argv[1]

with open(where, encoding='utf-8', errors='replace') as f:
    contents = f.read()

lines = contents.splitlines()
nerrors = 0
for line in lines:
    if 'multiply defined' in line:
        print(line)
        nerrors += 1

if nerrors > 0:
    sys.exit(1)
else:
    sys.exit(0)
    