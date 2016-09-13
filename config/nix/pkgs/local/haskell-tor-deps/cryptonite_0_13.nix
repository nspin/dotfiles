{ mkDerivation, base, byteable, bytestring, deepseq, ghc-prim
, integer-gmp, memory, stdenv, tasty, tasty-hunit, tasty-kat
, tasty-quickcheck
}:
mkDerivation {
  pname = "cryptonite";
  version = "0.13";
  sha256 = "1m1ancmz7wpv3y3clg73yli9wl54a8nm0yyjcchayzgsm3yxz2nd";
  libraryHaskellDepends = [
    base bytestring deepseq ghc-prim integer-gmp memory
  ];
  testHaskellDepends = [
    base byteable bytestring memory tasty tasty-hunit tasty-kat
    tasty-quickcheck
  ];
  homepage = "https://github.com/haskell-crypto/cryptonite";
  description = "Cryptography Primitives sink";
  license = stdenv.lib.licenses.bsd3;
}
