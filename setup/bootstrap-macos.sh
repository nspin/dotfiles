set -e

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

export MY_DOTFILES=/cfg/dotfiles
export MY_LOCAL=/cfg/local
export MY_NIXPKGS=/cfg/nixpkgs
export NIXPKGS_CONFIG="$MY_DOTFILES/nix/pkgs/config.nix"
export NIX_PATH="nixpkgs=$MY_NIXPKGS:dotfiles=$MY_DOTFILES:local=$MY_LOCAL"

nix-env -f '<nixpkgs>' -iA darwin-env

update-dotfile-links
