{ mkDerivation, base, Cabal, deepseq, old-locale, process
, QuickCheck, stdenv, test-framework, test-framework-quickcheck2
, unix
}:
mkDerivation {
  pname = "time";
  version = "1.4.2";
  sha256 = "1kpsak2wka23c8591ry6i1d7hmd54s7iw5n6hpx48jhcxf1w199h";
  revision = "2";
  editedCabalFile = "24f62a7c05992f2edacef1dcd80c1c6691f2d2b637acb8b326ca740b9687ee68";
  libraryHaskellDepends = [ base deepseq old-locale ];
  testHaskellDepends = [
    base Cabal deepseq old-locale process QuickCheck test-framework
    test-framework-quickcheck2 unix
  ];
  homepage = "http://semantic.org/TimeLib/";
  description = "A time library";
  license = stdenv.lib.licenses.bsd3;
}
