#!/bin/zsh
tmp=.tmpfile
for a in `git diff --name-only `; do
# for a in `git diff --name-only --cached`; do
echo $a;
    if [[ $a =~ '.tex' ]];
    then
    cp $a $tmp;
    ./latexindent.sh $a;
diff $tmp $a;
else
echo "Not a tex file"
fi
done

rm -f $tmp