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

echo -n "# CREATING $OLD ... "
mkdir -p $OLD
echo "DONE"

for DIR in $DIRS ; do
    CURR=$(pwd)/$DIR
    echo "# ADDING FILES IN $CURR"
    for FILE in $(ls $CURR) ; do
        echo "    $FILE"
        mv ~/.$FILE $OLD/$FILE
        ln -s -T $CURR/$FILE ~/.$FILE
    done
    echo "  ... DONE"
done

echo "# COMPLETE"
echo ""
