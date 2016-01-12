{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

{
  fzf-tmux = callPackage (import ./fzf-tmux) {};
  ycm = callPackage (import ./ycm) {};
  pandoc-citeproc = nixpkgs.haskell.lib.dontCheck (
    haskellPackages.callPackage (import ./pandoc-citeproc.nix) {}
  );
}
