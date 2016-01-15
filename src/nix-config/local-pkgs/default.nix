{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

{
  mars = callPackage (import ./mars) {};
  fzf-tmux = callPackage (import ./fzf-tmux) {};
  ycm = callPackage (import ./ycm) {};
  pandoc-citeproc = nixpkgs.haskell.lib.dontCheck (
    haskellPackages.callPackage (import ./pandoc-citeproc) {}
  );
}
