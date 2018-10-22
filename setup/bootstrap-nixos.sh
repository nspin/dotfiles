export MY_DOTFILES=/cfg/dotfiles
export MY_LOCAL=/cfg/local
export MY_NIXPKGS=/cfg/nixpkgs
export NIX_PATH="nixpkgs=$MY_NIXPKGS:dotfiles=$MY_DOTFILES:local=$MY_LOCAL:private=$MY_PRIVATE:nixos-config=$MY_LOCAL/config.nix"

nixos-rebuild switch && update-dotfile-links
