export MY_DOTFILES=/cfg/dotfiles
export MY_LOCAL=/cfg/local
export MY_NIXPKGS=/cfg/nixpkgs
export NIXPKGS_CONFIG="$MY_DOTFILES/nix/pkgs/config.nix"
export NIXOS_CONFIG="$MY_LOCAL/config.nix"
export NIX_PATH="nixpkgs=$MY_NIXPKGS:dotfiles=$MY_DOTFILES:local=$MY_LOCAL:private=$MY_PRIVATE:nixpkgs-overlays=$MY_DOTFILES/nix/pkgs/overlays.nix"

nixos-rebuild switch
