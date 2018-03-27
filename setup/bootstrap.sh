export MY_SYSTEM=linux
export MY_DOTFILES=/cfg/dotfiles
export MY_LOCAL=/cfg/local
export NIXOS_CONFIG="$MY_LOCAL/configuration.nix"
export NIX_PATH="nixpkgs=/cfg/nixpkgs:nixos-config=$NIXOS_CONFIG:dotfiles=$MY_DOTFILES"
