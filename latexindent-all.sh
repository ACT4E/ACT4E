#!/bin/zsh

# for a in volumes/vol1/**/*.tex;
#     do echo $a;
#     ./latexindent.sh $a &  # Everything  in parallel
# done

for a in sag/*.tikz;
    do echo $a;
    ./latexindent.sh $a &  # Everything  in parallel
done
