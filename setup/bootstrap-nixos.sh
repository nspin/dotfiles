export MY_NIXPKGS=/cfg/nixpkgs
export MY_DOTFILES=/cfg/dotfiles
export MY_LOCAL=/cfg/local
export MY_PRIVATE=/cfg/private

export NIX_PATH="nixpkgs=$MY_NIXPKGS:dotfiles=$MY_DOTFILES:local=$MY_LOCAL:private=$MY_PRIVATE:nixos-config=$MY_DOTFILES/nix/module"

nixos-rebuild switch && update-dotfile-links
