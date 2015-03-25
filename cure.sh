#!/bin/bash
############################
# Makes all necessary symlinks in ~
# and moves old ones to $OLD
############################

OLD=~/dotfiles_old           # old dotfiles backup dir

read -p "# INPUT 'c' FOR CORE OR 'a' FOR All: " CHOICE
 echo "$CHOICE"

if [ $CHOICE == c ] ; then
    DIRS="core"
elif [ $CHOICE == a ] ; then
    DIRS="core extra"
else
    DIRS=""
fi

for DIR in $DIRS ; do
    echo -n "# REMOVING FILES IN $DIR ... "
    cd ./$DIR
    pwd
    for FILE in ./.??* ; do
	echo -n "$FILE"
        rm ~/$FILE
    done
    cd ..
    echo "DONE"
done

echo -n "# RESTORING FILES FROM $OLD ... "
cp $OLD/* $OLD/.??* ~
echo "DONE"

echo -n "# COMPLETE"
