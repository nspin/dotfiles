# Editing

export VISUAL=vim
export EDITOR=vim
export VIM=$HOME/dotfiles/config/vim

export NIX_PATH=$NIX_PATH:dotfig=$HOME/dotfiles/config

if [ -d $HOME/vim-runtime ]; then
    export VIMRUNTIME=$HOME/vim-runtime/runtime
else
    export VIMRUNTIME=/usr/share/vim/vim73
fi

# Git

export GIT_SSL_NO_VERIFY=true

# PATH

PATH=$HOME/dotfiles/bin:$PATH

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

export PATH
