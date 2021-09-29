#!/bin/zsh
tmp=.tmpfile
for a in `git diff --name-only `; do
# for a in `git diff --name-only --cached`; do
    echo $a;
    cp $a $tmp;
    ./latexindent.sh $a;
    diff $tmp $a;
done

rm -f $tmp