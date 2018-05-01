{ stdenv, callPackage

, gettext, pkgconfig, perl
, ncurses, python2, python3, ruby, lua

, libX11, libXext, libSM, libXpm, libXt, libXaw, libXau, libXmu, glib, libICE
, gtk3, gtk2

# , CoreServices, CoreData, Cocoa, Foundation, libobjc, cf-private

}:

# if gui
#   buildInputs = [
# 	  libX11 libXext libSM libXpm libXt libXaw libXau libXmu glib libICE
#   ] ++ (if args.gui == "gtk3" then [gtk3] else [gtk2]);

# if darwin
#   # default
#   buildInputs = [ Carbon Cocoa ];
#   # configurable
#   buildInputs = [ CoreServices CoreData Cocoa Foundation libobjc cf-private ];
#   NIX_LDFLAGS = "/System/Library/Frameworks/CoreFoundation.framework/Versions/A/CoreFoundation";

let
  common = callPackage <nixpkgs/pkgs/applications/editors/vim/common.nix> {};
in
stdenv.mkDerivation rec {
  name = "my-vim-${version}";

  inherit (common) version src postPatch hardeningDisable enableParallelBuilding meta;

  nativeBuildInputs = [ gettext pkgconfig perl];
  buildInputs = [ ncurses python2 python3 ruby lua ];

  patches = [ <nixpkgs/pkgs/applications/editors/vim/cflags-prune.diff> ];

  configureFlags = [
    "--with-features=huge"

    "--enable-gui=no"
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
