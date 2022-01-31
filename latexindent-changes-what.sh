#!/bin/zsh
tmp=.tmpfile
for a in `git diff --name-only `; do
# for a in `git diff --name-only --cached`; do
echo $a;
   if [[ $a == *".tex" ]];
    then
    # echo "$a is  a tex file"
    cp $a $tmp;
    ./latexindent.sh $a;
    diff $tmp $a;
    else
    echo "$a is not a tex file"
fi
done

rm -f $tmp