function nixtest () {
    nix-build -E "(import <nixpkgs> {}).callPackage ./$1 {}"
}

function nixhest () {
    nix-build -E "(import <nixpkgs> {}).haskellPackages.callPackage ./$1 {}"
}

function nder() {
    readlink $(echo $NIX_PATH | sed -rn 's/^.*nixpkgs=([^:]+):.*$/\1/p')
}

function nde() {
    efd $(nder)
}

alias nb='nix-build "<nixpkgs>" -A'
alias cabaldef='cabal2nix . > default.nix'
alias cabalsh='cp ~/dotfiles/store/shell.nix .'
alias snrs='sudo nixos-rebuild switch'
