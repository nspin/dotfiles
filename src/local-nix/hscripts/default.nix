with import <nixpkgs> {};

let
  /* hscript = callPackage (import ./lib) {}; */
  hscript = (import ./lib) { inherit stdenv ghc; };
  /* hscript = callPackage ./lib {}; */
  test = import ./test;

in hscript (test { attoparsec = haskellPackages.attoparsec; })
