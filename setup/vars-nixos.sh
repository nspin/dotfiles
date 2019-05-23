export MY_CFG=/cfg
export NIX_PROFILES="$HOME/.nix-profile /nix/var/nix/profiles/default /run/current-system/sw"

. ./vars-common.sh

nixosbuild() {
    nix-build '<top>' -A build.my.toplevel "$@"
}

profile=/nix/var/nix/profiles/system

snrs() {
    cfg=$(nixosbuild --no-out-link)
    if [ $? != 0 ]; then
        return $?
    fi
    echo "TOPLEVEL: $cfg"
    echo "linking profile"
    sudo nix-env -p $profile --set $cfg
    echo "switching to configuration"
    sudo $cfg/bin/switch-to-configuration boot
}
