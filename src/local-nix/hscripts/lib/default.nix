{ stdenv, ghc }:

{ name, src, cpp ? null, haskellInputs }:

stdenv.mkDerivation {
  inherit name src ghc haskellInputs;
  ghcname = ghc.name;
  buildInputs = [ ghc ];
  builder = ./builder.sh;
  cppFlags = if cpp != null
             then map (attr: "-D${attr}=\"${builtins.getAttr attr cpp}\"") (builtins.attrNames cpp)
             else "";
}
