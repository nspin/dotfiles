{ mkDerivation, base, containers, minibar, mtl, process, stdenv
, stm, text, unix, X11, xmonad, xmonad-contrib
}:
mkDerivation {
  pname = "xmonad-config";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [
    base containers minibar mtl process stm text unix X11 xmonad
    xmonad-contrib
  ];
  license = stdenv.lib.licenses.mit;
}
