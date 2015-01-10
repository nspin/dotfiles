#!/bin/bash
############################
# Makes all necessary symlinks to files/dirs in ~/dotfiles,
# and moves old ones to ~/dotfiles_old
############################

dir=~/dotfiles                  # dotfiles dir
olddir=~/dotfiles_old           # old dotfiles backup dir
xmodir=~/.xmonad
min="vimrc vim bashrc bash_profile gitconfig gitignore_global screenrc"
rest="tmux.conf xinitrc Xresources xmonad/xmonad.hs"

files=$basics

read -p "All (y/n)? " all

if [ $all == "y" ] ; then
    files=$files$xstuff
fi

echo $files

echo -n "Creating $olddir ..."
mkdir -p $olddir
echo "done"

echo -n "Changing to $dir ..."
cd $dir
echo "done"

echo -n "Creating $xmodir"
mkdir $xmodir
echo "done"

for file in $files; do
    echo -n "Moving existing $file from ~ to $olddir ..."
    mv ~/.$file ~/dotfiles_old/
    echo "done"
    echo -n "Creating symlink to $file in ~ ..."
    ln -s $dir/$file ~/.$file
    echo "done"
done
