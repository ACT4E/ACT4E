#!/usr/bin/env python3 
import sys

where = sys.argv[1]

with open(where) as f:
    contents = f.read()

if 'multiply defined' in contents:
    print('There are multiply defined references:\n\n'+contents)
    sys.exit(1)

sys.exit(0)