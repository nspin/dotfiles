alias n='nix-build'
alias na='nix-build -A'
alias nb='nix-build "<np>" -A'
alias nev='nix-env -f "<np>" -iA'
alias nevd='nix-env -f "<np>" -iA darwin-env'
alias cabaldef='cabal2nix . > default.nix'
alias cabalsh='cp ~/dotfiles/store/shell.nix .'
alias snrs='sudo nixos-rebuild switch'

function nixtest() {
    f="$1"
    shift
    nix-build -E "(import <nixpkgs> {}).callPackage ./$f {}" "$@"
}

function nixhest() {
    nix-build -E "(import <nixpkgs> {}).haskellPackages.callPackage ./$1 {}"
}

function nixshh() {
    nix-shell -E '((import <nixpkgs> {}).haskellPackages.callPackage ./. {}).env'
}

function nder() {
    echo $NIX_PATH | sed -rn 's/^.*nixpkgs=([^:]+):.*$/\1/p'
}

function nde() {
    efd $(nder)
}
