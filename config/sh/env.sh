# Editing

export VISUAL=vim
export EDITOR=vim
export VIM=$HOME/dotfiles/config/vim

if [ -d $HOME/vim-runtime ]; then
    export VIMRUNTIME=$HOME/vim-runtime/runtime
else
    version=$(vim --version | head -n 1 | cut -d ' ' -f 5 | sed 's/\.//')
    fallback=$(vim --version | grep 'fall-back' | cut -d '"' -f 2)
    export VIMRUNTIME=$fallback/vim$version
fi

# Nix

export NIX_PATH=$NIX_PATH:dotfig=$HOME/dotfiles/config

# Git

export GIT_SSL_NO_VERIFY=true

# PATH

PATH=$HOME/dotfiles/bin:$PATH
case "$(uname -s)" in
    Darwin) PATH=$HOME/dotfiles/bin/darwin:$PATH ;;
    Linux)  PATH=$HOME/dotfiles/bin/linux:$PATH ;;
esac

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

export PATH
