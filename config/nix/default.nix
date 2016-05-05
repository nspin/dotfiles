let
  pkgs = import <nixpkgs> {};
  config = import ./config.nix { inherit pkgs; };
in
  config.packageOverrides pkgs // pkgs
