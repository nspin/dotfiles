. $HOME/.nix-profile/etc/profile.d/nix.sh

export MY_NIXPKGS=$HOME/nixpkgs
export MY_DOTFILES=$HOME/dotfiles
export MY_LOCAL=$HOME/local
export MY_PRIVATE=$HOME/private

export NIX_PATH="nixpkgs=$MY_NIXPKGS:dotfiles=$MY_DOTFILES:local=$MY_LOCAL:private=$MY_PRIVATE:pkgs=$MY_DOTFILES/nix/pkgs.nix"

export NIX_PROFILES="$HOME/.nix-profile"

nix-env -f '<pkgs>' -iA env && update-dotfile-links
