set -e

. vars-nixos.sh

cfg=$(nix-build '<top>' -A build.toplevel --no-out-link)
sudo $cfg/bin/switch-to-configuration switch

export NIX_PROFILES="$HOME/.nix-profile /nix/var/nix/profiles/default /run/current-system/sw"

update-dotfile-links
