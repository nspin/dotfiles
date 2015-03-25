#!/bin/bash
############################
# Create, remove, backup, or restore symlinks
# in ~/ from specified subdirectories of ./
############################

echo ""

read -p "-- INFECT, CURE, BACKUP, OR RESTORE? (i/c/b/r) " CHOICE
read -p "-- ENTER CONFIG DIRECTORIES: (relative) " DIRS

if [ $CHOICE == b ] || [ $CHOICE == r ] ; then
    read -p "-- ENTER BACKUP DIRECTORY: (absolute) " BKP
    if [ $CHOICE == r ] ; then
        mkdir -d $BKP
    fi
fi

for DIR in $DIRS ; do
    CURR=$(pwd)/$DIR # complete path so that 'ln' behaves correctly
    echo "-- $CURR"
    for FILE in $(ls $CURR) ; do
        echo "--     $FILE"
        if [ $CHOICE == i ] ; then
            rm ~/.$FILE
            ln -s -T $CURR/$FILE ~/.$FILE
        elif [ $CHOICE == c ] ; then
            rm ~/.$FILE
        elif [ $CHOICE == b ] ; then
            mv ~/.$FILE $BKP
        elif [ $CHOICE == r ] ; then
            mv $BKP ~/.$FILE
        fi
    done
    echo "-- ... DONE"
done

echo "-- COMPLETE"

echo ""
