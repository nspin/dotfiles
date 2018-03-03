export MY_SYSTEM="darwin"
export MY_DOTFILES="$HOME/dotfiles"
export MY_LOCAL="$HOME/local"
export MY_VIM_BUNDLE="$HOME/vim-bundle/bundle"

if [ -e $MY_LOCAL/vim_plugin_path ]; then
    export MY_VIM_PLUGIN_PATH="$(cat $MY_LOCAL/vim_plugin_path | tr '\n' ':')"
fi

export PATH="$MY_LOCAL/bin:$MY_DOTFILES/bin/darwin:$MY_DOTFILES/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

export EDITOR=vim
export VISUAL=vim

export FZF_DEFAULT_OPTS='--reverse'

export NIX_PATH="nixpkgs=$HOME/nixpkgs:dotfiles=$MY_DOTFILES:local=$MY_LOCAL"
