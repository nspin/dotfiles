export MY_SYSTEM="darwin"
export MY_DOTFILES="$HOME/dotfiles"
export MY_LOCAL="$HOME/local"

export NIX_PATH="nixpkgs=$HOME/nixpkgs:dotfiles=$MY_DOTFILES:local=$MY_LOCAL"
export NIX_PROFILES="/nix/var/nix/profiles/per-user/$USER/profile /nix/var/nix/profiles/default"

export PATH="$MY_LOCAL/bin:$PATH"
export PATH="$MY_DOTFILES/bin/darwin:$MY_DOTFILES/bin:$PATH"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="/opt/local/bin:$PATH"

export EDITOR=vim
export VISUAL=vim

export FZF_DEFAULT_OPTS='--reverse'
