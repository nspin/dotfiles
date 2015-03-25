#!/bin/bash
############################
# Makes all necessary symlinks to files/dirs in ~/dotfiles,
# and moves old ones to ~/dotfiles_old
# (note space at end of min)
############################

dir=~/dotfiles/core             # dotfiles dir
olddir=~/dotfiles_old           # old dotfiles backup dir
min="vimrc vim bashrc bash_profile gitconfig gitignore_global screenrc "
rest="tmux.conf xinitrc Xresources xmonad"

files=$min

read -p "All (y/n)? " all

if [ $all == "y" ] ; then
    files=$files$rest
fi

echo -n "Creating $olddir ..."
mkdir -p $olddir
echo "done"

echo -n "Changing to $dir ..."
cd $dir
echo "done"

for file in $files; do
    echo -n "Moving existing $file from ~ to $olddir ..."
    mv ~/.$file $olddir
    echo "done"
    echo -n "Creating symlink to $file in ~ ..."
    ln -s $dir/$file ~/.$file
    echo "done"
done
