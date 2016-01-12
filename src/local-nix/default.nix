{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

{
  fzf-tmux = callPackage (import ./fzf-tmux) {};
  ycm = callPackage (import ./ycm) {};
}
