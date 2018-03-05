with import <nixpkgs> {};
let
  f = import ./. {};
  xmc = haskellPackages.callPackage f {};
in xmc.env
# in lib.overrideDerivation xmc (self: {
#   buildInputs = self.buildInputs ++ [
#     haskellPackages.cabal-install
#   ];
# })
