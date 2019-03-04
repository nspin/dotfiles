#!/bin/sh

prefix="https://raw.githubusercontent.com/junegunn/fzf/master/shell"

for file in completion.bash key-bindings.bash; do
    curl $prefix/$file > $MY_DOTFILES/config/bash/fzf/$file
done
