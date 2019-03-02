alias n='nix-build'
alias na='nix-build -A'
alias nb='nix-build "<pkgs>" -A'
alias nev='nix-env -f "<pkgs>" -iA'
alias nevd='nix-env -f "<pkgs>" -iA darwin-env'
alias cabaldef='cabal2nix . > default.nix'
alias cabalsh='cp ~/dotfiles/store/shell.nix .'
# alias snrs='sudo nixos-rebuild switch --fast --no-build-nix'
alias snrs='sudo nixos-rebuild switch'

function nixtest() {
    f="$1"
    shift
    nix-build -E "(import <pkgs>).callPackage ./$f {}" "$@"
}

function nixhest() {
    nix-build -E "(import <pkgs>).haskellPackages.callPackage ./$1 {}"
}

function nixshh() {
    nix-shell -E '((import <pkgs>).haskellPackages.callPackage ./. {}).env'
}

function nder() {
    echo $NIX_PATH | sed -rn 's/^.*nixpkgs=([^:]+):.*$/\1/p'
}

function nde() {
    efd $(nder)
}

function nixinstall() {
    f="$1"
    shift
    nix-env -f '<pkgs>' -iE "x: x.callPackage ./$f {}" "$@"
}
