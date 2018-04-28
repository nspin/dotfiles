export MY_SYSTEM=linux
export MY_DOTFILES=/cfg/dotfiles
export MY_LOCAL=/cfg/local
export NIXPKGS_CONFIG="$MY_DOTFILES/nix/pkgs/config.nix"
export NIXOS_CONFIG="$MY_LOCAL/config.nix"
export NIX_PATH="nixpkgs=/cfg/nixpkgs:dotfiles=$MY_DOTFILES:local=$MY_LOCAL"
