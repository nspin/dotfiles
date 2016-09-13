{ mkDerivation, base, deepseq, QuickCheck, stdenv, test-framework
, test-framework-quickcheck2, unix
}:
mkDerivation {
  pname = "time";
  version = "1.5.0.1";
  sha256 = "0knixcmdsl2jhjw0x6is02yrw6dhjn4gr3fh06adc003gc3wr894";
  revision = "1";
  editedCabalFile = "49a05dd0624dadeb114cbf0d6696864657885e78521ff935361ca20ef65c615f";
  libraryHaskellDepends = [ base deepseq ];
  testHaskellDepends = [
    base deepseq QuickCheck test-framework test-framework-quickcheck2
    unix
  ];
  homepage = "https://github.com/haskell/time";
  description = "A time library";
  license = stdenv.lib.licenses.bsd3;
}
