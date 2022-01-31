#!/usr/bin/env python3 
import sys

where = sys.argv[1]

with open(where) as f:
    contents = f.read()

if 'undefined on input line' in contents:
    print('There are undefined references:\n\n'+contents)
    sys.exit(1)

sys.exit(0)