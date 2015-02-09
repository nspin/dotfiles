#!/bin/bash
############################
# Makes all necessary symlinks in ~
# and moves old ones to $OLD
############################

OLD=~/dotfiles_old           # old dotfiles backup dir

echo ""

read -p "# INPUT 'c' FOR CORE OR 'a' FOR All: " CHOICE

if [ $CHOICE == c ] ; then
    DIRS="core"
elif [ $CHOICE == a ] ; then
    DIRS="core extra"
else
    DIRS=""
fi

for DIR in $DIRS ; do
    CURR=$(pwd)/$DIR
    echo "# REMOVING FILES IN $CURR"
    for FILE in $(ls $CURR) ; do
        echo "    $FILE"
        rm ~/.$FILE
    done
    echo "  ... DONE"
done

echo "# RESTORING FILES IN $OLD"
for OLDFILE in $(ls $OLD) ; do
    echo "    $OLDFILE"
    mv $OLD/$OLDFILE ~/.$OLDFILE
done
echo "  ... DONE"

echo "# COMPLETE"
echo ""
