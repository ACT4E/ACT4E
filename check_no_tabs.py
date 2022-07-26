#!/usr/bin/env python3
import itertools
import sys
from pathlib import Path
from typing import List, Tuple
import fnmatch
import os.path

try:
    import termcolor
except ImportError:
    def colored(text: str, color=None, on_color=None) -> str:
        return text 
else:
    from termcolor import colored

directories = sys.argv[1:]
if not directories:
    print("Need to pass directories or files to check on the command line.")
    raise SystemExit(1)

patterns = ["*.tex", "*.tikz", "*.py", "*.sh"]

files = []

for d, p in itertools.product(directories, patterns):
    if os.path.isdir(d):
        for fn in Path(d).rglob(p):
            files.append(fn)
    else:
        if fnmatch.fnmatch(d, p):
            files.append(d)
            
errors: List[Tuple[Path, int, str, int]] = []

for fn in files:
    with open(fn) as f:
        contents = f.read()
    lines = contents.splitlines()
    for i, line in enumerate(lines):
        if "\t" in line:
            ntabs = line.count("\t")
            errors.append((fn, i, line, ntabs))

if not errors:
    print(f"No errors found in {len(files)} files.")
    raise SystemExit(0)

files_with_errors = set(path for path, i, line, ntabs in errors)
number_lines = len(errors)
number_tabs = sum(ntabs for path, i, line, ntabs in errors)

s = (
    f"Found {len(files_with_errors)} files with a total of {number_lines} lines with {number_tabs} tabs "
    f"contained."
)

print(colored(s, "red"))

for fn in files_with_errors:
    its = [(i, line) for path, i, line, ntabs in errors if path == fn]
    print(colored(str(fn), "green"))
    for i, line in its:
        tab_highlight = colored(">---", "red", "on_white")
        line_highlight = line.replace("\t", tab_highlight)
        print(f"line {i + 1:3d}: {line_highlight}")
# print(files)

print(colored(s, "red"))

raise SystemExit(1)
