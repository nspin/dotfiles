set -e

. ./vars-macos.sh

nix-env -f '<top>' -iA pkgs.env

update-dotfile-links
