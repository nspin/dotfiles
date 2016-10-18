{ mkDerivation, array, base, bytestring, Cabal, containers
, directory, filepath, HUnit, QuickCheck, random, stdenv
, test-framework, test-framework-quickcheck2
}:
mkDerivation {
  pname = "binary";
  version = "0.8.3.0";
  sha256 = "08d85qzna6zdkpgqwaw1d87biviv1b76zvk5qs3gg4kxwzfqa4r2";
  revision = "1";
  editedCabalFile = "21a7449af6a6caa19c3b5c877c2331ccd3842ef1e9ab59c65918fbde0f6ac427";
  libraryHaskellDepends = [ array base bytestring containers ];
  testHaskellDepends = [
    array base bytestring Cabal containers directory filepath HUnit
    QuickCheck random test-framework test-framework-quickcheck2
  ];
  homepage = "https://github.com/kolmodin/binary";
  description = "Binary serialisation for Haskell values using lazy ByteStrings";
  license = stdenv.lib.licenses.bsd3;
}
