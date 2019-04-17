set -e

. ./vars-macos.sh

nix-env -f '<top>' -iA pkgs.env

export NIX_PROFILES=$HOME/.nix-profile

update-dotfile-links
