{ mkDerivation, ansi-terminal, attoparsec, base, containers, mtl
, process, stdenv, stm, terminal-size, text, unix, X11, xmonad
, xmonad-contrib, bytestring, transformers
}:

isLaptop:

mkDerivation {
  pname = "xmonad-config";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    ansi-terminal attoparsec base containers mtl process stm
    terminal-size text unix X11 xmonad xmonad-contrib
    bytestring transformers
  ];
  executableHaskellDepends = [ base ];
  license = stdenv.lib.licenses.mit;
  configureFlags = if isLaptop then [ "-f laptop" ] else [];
}
