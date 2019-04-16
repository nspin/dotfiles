set -e

here=$(dirname $_)

. $here/vars-nixos.sh

nix-env -f '<top>' -iA pkgs.env

export NIX_PROFILES=$HOME/.nix-profile

update-dotfile-links
