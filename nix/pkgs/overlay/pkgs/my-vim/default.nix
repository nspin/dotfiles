{ stdenv, lib, callPackage

, gui ? "no"

, gettext, pkgconfig, perl
, ncurses, python2, python3, ruby, lua

, libX11, libXext, libSM, libXpm, libXt, libXaw, libXau, libXmu, glib, libICE
, gtk3, gtk2

, CoreServices, CoreData, Cocoa, Foundation, libobjc, cf-private

}:

let
  common = callPackage <nixpkgs/pkgs/applications/editors/vim/common.nix> {};

in stdenv.mkDerivation rec {
  name = "my-vim-${version}";

  inherit (common) version src postPatch hardeningDisable enableParallelBuilding meta;

  nativeBuildInputs = [ gettext pkgconfig perl];
  buildInputs = [ ncurses python2 python3 ruby lua ]
    ++ lib.optionals stdenv.isDarwin
        [ CoreServices CoreData Cocoa Foundation libobjc cf-private ]
    ++ lib.optionals (!stdenv.isDarwin && gui != "no")
	    ([ libX11 libXext libSM libXpm libXt libXaw libXau libXmu glib libICE ]
          ++ (if gui == "gtk3" then [gtk3] else [gtk2]));

  patches = [ <nixpkgs/pkgs/applications/editors/vim/cflags-prune.diff> ];

  configureFlags = [
    "--with-features=huge"

    "--enable-gui=${gui}"
    "--enable-multibyte"
    "--enable-nls"
    "--enable-cscope"

	"--enable-mzschemeinterp"
	"--enable-python3interp"
	"--enable-perlinterp"
	"--enable-rubyinterp"
	"--enable-luainterp"

	"--with-lua-prefix=${lua}"
    "--with-python3-config-dir=${python3}/lib"
  ];

  NIX_LDFLAGS = lib.optional stdenv.isDarwin
    "/System/Library/Frameworks/CoreFoundation.framework/Versions/A/CoreFoundation";

  postInstall = ''
    ln -s $out/bin/vim $out/bin/vi
  '';

  __impureHostDeps = [ "/dev/ptmx" ];

  # To fix the trouble in vim73, that it cannot cross-build with this patch
  # to bypass a configure script check that cannot be done cross-building.
  # http://groups.google.com/group/vim_dev/browse_thread/thread/66c02efd1523554b?pli=1
  # patchPhase = ''
  #   sed -i -e 's/as_fn_error.*int32.*/:/' src/auto/configure
  # '';
}
