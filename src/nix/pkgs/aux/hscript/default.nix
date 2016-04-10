{ stdenv, ghcPkgDb }:

/* Build a simple Haskell program using ghc-pkgs-db
 */

{ name, src, cpp ? {}, hp ? haskellPackages, f }:

stdenv.mkDerivation {
  inherit name src;
  pkgdb = ghcPkgDB hp f;
  ghcName = hp.ghc.name;
  builder = ./builder.sh;
  buildInputs = [ hp.ghc ];
  cppPairs = builtins.concatLists (map (attr: [attr (builtins.getAttr attr cpp)]) (builtins.attrNames cpp));
}
