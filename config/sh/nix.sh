alias n='nix-build'
alias na='nix-build -A'
alias ne='nef ./.'
alias nb='nix-build "<pkgs>" -A'
alias nev='nix-env -f "<pkgs>" -iA'
alias nevd='nix-env -f "<pkgs>" -iA env'
alias cabaldef='cabal2nix . > default.nix'
alias cabalsh='cp ~/dotfiles/store/shell.nix .'
# alias snrs='sudo nixos-rebuild switch --fast --no-build-nix'
alias snrs='sudo nixos-rebuild switch'

nixtest() {
    f="$1"
    shift
    nix-build -E "(import <pkgs>).callPackage ./$f {}" "$@"
}

nixhest() {
    nix-build -E "(import <pkgs>).haskellPackages.callPackage ./$1 {}"
}

nixshh() {
    nix-shell -E '((import <pkgs>).haskellPackages.callPackage ./. {}).env'
}

nder() {
    echo $NIX_PATH | sed -rn 's/^.*nixpkgs=([^:]+):.*$/\1/p'
}

nde() {
    efd $(nder)
}

nixinstall() {
    f="$1"
    shift
    nix-env -f '<pkgs>' -iE "x: x.callPackage ./$f {}" "$@"
}

nef() {
    nix-instantiate --eval --expr "with import $1; $2"
}
