##!/bin/bash
#################################################
# Creates symlinks from files in ./home to $HOME,
# backing up old files in a directory called
# 'seliftod/(seconds since 1970)', unless the
# script is called with an argument.
#################################################

source=$HOME/dotfiles/home

function finish {
    echo "-- $1"
    echo "=============================="
    echo ""
    exit
}

echo ""
echo "=============================="

if [[ -z $1 ]] ; then
    bkp=$HOME/seliftod/$(date +%s)
    mkdir -p $HOME/seliftod
    mkdir $bkp || finish "Could not create $bkp"
else
    read -p "-- Confirm no backup? (y/*) " choice
    if [[ "$choice" != "y" ]] ; then
        finish Aborting
    fi
fi

echo "-- Creating new links from"
echo "--   $source"
echo "--     to"
echo "--   $HOME"
echo "-- and moving old links/files to"
echo "--   $bkp"
echo ""

for file in $(ls $source) ; do
    echo "-- $file"
    if [[ -e $HOME/.$file ]] || [[ -h $HOME/.$file ]] ; then
        if [[ -z $1 ]] ; then
            mv "$HOME/.$file" "$bkp"
        else
            rm "$HOME/.$file"
       fi
    fi
    ln -s $source/$file $HOME/.$file
done

echo ""
finish Complete
