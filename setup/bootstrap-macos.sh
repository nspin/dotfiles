set -e

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

export MY_NIXPKGS=$HOME/nixpkgs
export MY_DOTFILES=$HOME/dotfiles
export MY_LOCAL=$HOME/local
export MY_PRIVATE=$HOME/private

export NIXPKGS_CONFIG="$MY_DOTFILES/nix/pkgs/config.nix"
export NIX_PATH="nixpkgs=$MY_NIXPKGS:dotfiles=$MY_DOTFILES:local=$MY_LOCAL:private=$MY_PRIVATE:nixpkgs-overlays=$MY_DOTFILES/nix/pkgs/overlays.nix"

nix-env -f '<nixpkgs>' -iA darwin-env

update-dotfile-links