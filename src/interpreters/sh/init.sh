export VISUAL=vim
export EDITOR=$VISUAL
export VIM=/home/nick/dotfiles/src/editors/vim/init/
export VIMRUNTIME=/home/nick/vim-runtime/runtime

basedir=$HOME/dotfiles/src/interpreters/sh

PATH=$basedir/bin:$PATH

if test -d $HOME/bin; then
    PATH=$HOME/bin:$PATH
fi

for script in $basedir/util/*.sh; do
    source $script
done
