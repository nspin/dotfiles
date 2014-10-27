#!/bin/bash
############################
# .make.sh
# makes all necessary symlinks to files/dirs in ~/dotfiles,
# and moves old ones to ~/dotfiles_old
############################

dir=~/dotfiles                  # dotfiles dir
olddir=~/dotfiles_old           # old dotfiles backup dir
files="vimrc vim"               # files/dirs to symlink in ~

echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
