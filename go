#!/bin/sh

(while read line; do
    read link target <<< $(echo $line | awk '{ print $1; print $2; }')
    mkdir -p $(dirname $target)
    echo "ln -sfnv $CFGDIR/dotfiles/config/$link $HOME/$target"
    ln -sfnv $CFGDIR/dotfiles/config/$link $HOME/$target
done) < $(dirname $0)/setup/$1
