#!/bin/bash
############################
# Makes all necessary symlinks in ~
# and moves old ones to $OLD
############################

OLD=~/dotfiles_old           # old dotfiles backup dir

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
    echo -n "# ADDING FILES IN "
    cd $DIR
    pwd
    for FILE in * ; do
	echo "    $FILE"
        mv ~/.$FILE $OLD
        ln -s -T $FILE ~/.$FILE
    done
    cd ..
    echo "  ... DONE"
done

echo -n "# COMPLETE"
echo -n ""
