# nix
alias nb='nix-build "<dotfig/nix>" -A'
alias cabaldef='cabal2nix . > default.nix'
alias cabalsh='cp ~/dotfiles/store/shell.nix .'

alias snrs='sudo nixos-rebuild switch'

function venv() {
    source ~/python-envs/$1/bin/activate
}
