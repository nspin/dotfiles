#!/bin/bash
############################
# Makes all necessary symlinks in ~
# and moves old ones to $OLD
############################

OLD=~/dotfiles_old           # old dotfiles backup dir

read -p "# INPUT \"c\" FOR CORE OR \"a\" FOR All: " $CHOICE

if [ $CHOICE == "c" ] ; then
    $DIRS="core"
elif [ $CHOICE == "a" ] ; then
    $DIRS="core extras"
else
    $DIRS=""
fi

echo -n "# CREATING $OLD"
mkdir -p $OLD
echo "DONE"

for DIR in $DIRS ; do
    echo -n "# ADDING FILES IN $DIR ..."
    cd $DIR
    for FILE in ./* ; do
        mv ~/$FILE $OLD
        ln -s $FILE ~
    done
    cd ..
    echo "DONE"
done

echo -n "# COMPLETE"
