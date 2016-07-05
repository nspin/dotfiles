{ mkDerivation, ansi-terminal, base, containers, mtl, process
, stdenv, stm, terminal-size, text, unix, X11, xmonad
, xmonad-contrib
}:
mkDerivation {
  pname = "xmonad-config";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [
    ansi-terminal base containers mtl process stm terminal-size text
    unix X11 xmonad xmonad-contrib
  ];
  license = stdenv.lib.licenses.mit;
}
