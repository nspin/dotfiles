export VISUAL=vim
export EDITOR=$VISUAL
export VIM=/home/nick/vim-config
export VIMRUNTIME=/home/nick/vim-runtime/runtime

basedir=$HOME/dotfiles/src/interpreters

PATH=$basedir/sh/bin:$PATH

if test -d $HOME/bin; then
    PATH=$HOME/bin:$PATH
fi

for script in $basedir/sh/util/*.sh; do
    source $script
done
