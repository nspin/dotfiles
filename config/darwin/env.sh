export DOTFILES=$HOME/dotfiles
export VIM_BUNDLE=$HOME/vim-bundle/bundle
export MY_LOCAL=$HOME/local

if [ -d $HOME/vim-runtime ]; then
    export VIMRUNTIME=$HOME/vim-runtime/runtime
else
    version=$(vim --version | head -n 1 | sed -E 's/^[^0-9]*([0-9]+)\.([0-9]+).*/\1\2/')
    fall_back=$(vim --version | grep fall-back | cut -d '"' -f 2)
    export VIMRUNTIME=$fall_back/vim$version
fi

export PATH=$MY_LOCAL/bin:$DOTFILES/bin/darwin:$DOTFILES/bin:$PATH
if [ -d $HOME/bin ]; then
    export PATH=$HOME/bin:$PATH
fi

export EDITOR=vim
export VISUAL=vim

export VIM=$DOTFILES/config/vim
export VIMRUNTIME=$VIMRUNTIME # TODO
export FZF_DEFAULT_OPTS='--reverse'
export GIT_SSL_NO_VERIFY=true

export NIX_PATH=$NIX_PATH:dotfig=$DOTFILES/config
