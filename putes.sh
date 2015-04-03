#!/bin/bash
#################################################
# Removes symlinks from $HOME with the same name
# as files in ./home
#################################################

echo ""
echo "-- Removing..."
for file in $(ls $HOME/dotfiles/home) ; do
    echo "--     $file"
    if [[ -h $HOME/.$file ]] ; then
        rm "$HOME/.$file"
    fi
done

echo "-- Complete"
echo ""
