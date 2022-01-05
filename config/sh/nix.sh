alias ni='nix-build'
alias na='nix-build -A'
alias nefh='nef ./.'
alias nb='nix-build "<pkgs>" -A'
alias ns='nix-shell'
alias nev='nix-env -f "<pkgs>" -iA'
alias nevd='nix-env -f "<pkgs>" -iA env'
alias cabaldef='cabal2nix . > default.nix'
alias cabalsh='cp ~/dotfiles/store/shell.nix .'

snr() {
    profile=/nix/var/nix/profiles/system
    cfg=$(nixosbuild --no-out-link)
    if [ $? != 0 ]; then
        return $?
    fi
    echo "TOPLEVEL: $cfg"
    echo "linking profile"
    sudo nix-env -p $profile --set $cfg
    echo "switching to configuration"
    sudo $cfg/bin/switch-to-configuration $1
}

alias snrs='snr switch'
alias snrb='snr boot'

nixosbuild() {
    nix-build '<top>' -A build.toplevel "$@"
}

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
