export MY_NIXPKGS=$MY_CFG/nixpkgs
export MY_DOTFILES=$MY_CFG/dotfiles
export MY_LOCAL=$MY_CFG/local
export MY_PRIVATE=$MY_CFG/private

export NIX_PATH="nixpkgs=$MY_NIXPKGS:dotfiles=$MY_DOTFILES:local=$MY_LOCAL:private=$MY_PRIVATE:top=$MY_DOTFILES/nix"
