export DOTFILES="$HOME/dotfiles"
export VIM_BUNDLE="$HOME/vim-bundle/bundle"
export MY_LOCAL="$HOME/local"

if [ -f $MY_LOCAL/vim_plugin_path ]; then
    export VIM_PLUGIN_PATH="$(cat $MY_LOCAL/vim_plugin_path | tr '\n' ':')"
fi

export PATH="$MY_LOCAL/bin:$DOTFILES/bin/darwin:$DOTFILES/bin:$HOME/bin:$PATH"

# for macports
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

export EDITOR=vim
export VISUAL=vim

export FZF_DEFAULT_OPTS='--reverse'

export NIX_PATH="nixpkgs=$HOME/nixpkgs:dotfig=$DOTFILES/config"
