#!/bin/sh
basedir="$HOME/dotfiles"

(while read line; do
    read link target <<< $(echo $line | awk '{ print $1; print $2; }')
    mkdir -p $(dirname $target)
    ln -sfnv $basedir/config/$link $target
done) < $(dirname $0)/setup/$1
