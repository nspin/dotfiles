#!/bin/bash
############################
# Create, remove, backup, or restore symlinks
# in ~/ from specified subdirectories of ./
############################

echo ""

read -p "-- INFECT, CURE, BACKUP, OR RESTORE? (i/c/b/r) " CHOICE
read -p "-- ENTER CONFIG DIRECTORIES: (relative to ~/dotfiles/core) " DIRS

if [ $CHOICE == b ] || [ $CHOICE == r ] ; then
    read -p "-- ENTER BACKUP DIRECTORY: (relative to ~) " BKP
    if [ $CHOICE == b ] ; then
        mkdir -p ~/$BKP
    fi
fi

for DIR in $DIRS ; do
    CURR=$HOME/dotfiles/core/$DIR
    echo "-- $CURR"
    for FILE in $(ls $CURR) ; do
        echo "--     $FILE"
        if [ $CHOICE == i ] ; then
            ln -s -f $CURR/$FILE ~/.$FILE
        elif [ $CHOICE == c ] && [ -e ~/.$FILE ]; then
            rm ~/.$FILE
        elif [ $CHOICE == b ] && [ -e ~/.$FILE ] ; then
            mv ~/.$FILE ~/$BKP/$FILE
        elif [ $CHOICE == r ] && [ -e ~/$BKP/$FILE ] ; then
            mv ~/$BKP/$FILE ~/.$FILE
        fi
    done
    echo "-- ... DONE"
done

echo "-- COMPLETE"

echo ""
