{ mkDerivation, base, bytestring, deepseq, ghc-prim, stdenv, tasty
, tasty-hunit, tasty-quickcheck
}:
mkDerivation {
  pname = "memory";
  version = "0.10";
  sha256 = "1xqs9zmjbjihb7gfbk25f2q00m2lsi4kc3jv672175ac8a36pgag";
  revision = "1";
  editedCabalFile = "077f03d446f54b00ecc4b9b3af646532f6e9d0a455b911ddfaf2484507c48433";
  libraryHaskellDepends = [ base bytestring deepseq ghc-prim ];
  testHaskellDepends = [ base tasty tasty-hunit tasty-quickcheck ];
  homepage = "https://github.com/vincenthz/hs-memory";
  description = "memory and related abstraction stuff";
  license = stdenv.lib.licenses.bsd3;
}
