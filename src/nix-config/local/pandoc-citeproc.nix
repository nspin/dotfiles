{ mkDerivation, aeson, aeson-pretty, attoparsec, base, bytestring
, containers, data-default, directory, filepath, hs-bibutils, mtl
, old-locale, pandoc, pandoc-types, parsec, process, rfc5051
, setenv, split, stdenv, syb, tagsoup, temporary, text, time
, vector, xml-conduit, yaml
}:
mkDerivation {
  pname = "pandoc-citeproc";
  version = "0.8.0.1";
  sha256 = "0sbjlgm5lgdlmm1c7arynpy3vw1i5g7p9hxhzrvl37ajmjwfvqgr";
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson base bytestring containers data-default directory filepath
    hs-bibutils mtl old-locale pandoc pandoc-types parsec rfc5051
    setenv split syb tagsoup text time vector xml-conduit yaml
  ];
  executableHaskellDepends = [
    aeson aeson-pretty attoparsec base bytestring containers directory
    filepath pandoc pandoc-types process syb temporary text vector yaml
  ];
  testHaskellDepends = [
    aeson base bytestring directory filepath pandoc pandoc-types
    process temporary text yaml
  ];
  description = "Supports using pandoc with citeproc";
  license = stdenv.lib.licenses.bsd3;
}
