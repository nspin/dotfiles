#!/bin/bash
#####################################
# Create, remove, backup, or restore
# symlinks from $HOME to ./home
#####################################

echo ""

read -p "-- Infect, cure, backup, or restore? (i/c/b/r) " choice

if [[ $choice == b ]] || [[ $choice == r ]] ; then
    read -p "-- Enter backup directory: (relative to ~) " rel
    $bkp=$HOME/$rel
    if [[ $choice == b ]] ; then
        mkdir -p $bkp
    fi
fi

dir="$HOME/dotfiles/home"

for file in $(ls $dir) ; do
    echo "--     $file"
    if [ $choice == i ] ; then
        ln -s $dir/$file $HOME/.$file
    elif [ $choice == c ] && [ -h $HOME/.$file ] ; then
        rm $HOME/.$file
    elif [ $choice == b ] && [ -e $HOME/.$file ] ; then
        mv $HOME/.$file $bkp/$file
    elif [ $choice == r ] && [ -e $bkp/$file ] ; then
        mv $bkp/$file $HOME/.$file
    fi
done

echo "-- Complete"

echo ""
