export MY_CFG=/cfg
export NIX_PROFILES="$HOME/.nix-profile /nix/var/nix/profiles/default /run/current-system/sw"

. ./vars-common.sh

nixosbuild() {
    nix-build '<top>' -A build.toplevel "$@"
}

profile=/nix/var/nix/profiles/system

snr() {
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

snrb() {
    snr boot
}

snrs() {
    snr switch
}
