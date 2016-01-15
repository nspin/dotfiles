with import <nixpkgs> {};

let
  hlib = callPackage ./hlib {};

in hlib.mkDerivation (hlib.callPackage ./test {})
