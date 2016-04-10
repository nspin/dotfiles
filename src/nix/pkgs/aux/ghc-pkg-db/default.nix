{ stdenv }:

/* Build a ghc-pkg database the given:
 *  - hp: haskellPackages
 *  - f: haskellPackages -> [actual Haskell packages]
 */

hp: f: stdenv.mkDerivation {
  name = "ghc-pkg-db";
  inherit (hp) ghc;
  ghcName = hp.ghc.name;
  libs = f hp;
  builder = ./builder.sh;
}

