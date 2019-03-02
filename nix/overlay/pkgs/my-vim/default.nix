{ stdenv, lib, callPackage, config

, gettext, pkgconfig, perl
, ncurses, python3, ruby, lua

, libX11, libXext, libSM, libXpm, libXt, libXaw, libXau, libXmu, glib, libICE
, gtk3, gtk2

, CoreServices, CoreData, Cocoa, Foundation, libobjc, cf-private

, guiSupport        ? config.vim.gui or "no"
, netbeansSupport   ? config.netbeans or true
, darwinSupport     ? config.vim.darwin or false

}:

let
  common = callPackage <nixpkgs/pkgs/applications/editors/vim/common.nix> {};

in stdenv.mkDerivation rec {
  name = "my-vim-${version}";

  inherit (common) version src postPatch hardeningDisable enableParallelBuilding meta;

  nativeBuildInputs = [ gettext pkgconfig perl];
  buildInputs = [ ncurses python3 ruby lua ]
    ++ lib.optionals stdenv.isDarwin
        [ CoreServices CoreData Cocoa Foundation libobjc cf-private ]
    ++ lib.optionals (!stdenv.isDarwin && guiSupport != "no")
	    ([ libX11 libXext libSM libXpm libXt libXaw libXau libXmu glib libICE ]
          ++ (if guiSupport == "gtk3" then [gtk3] else [gtk2]));

  patches = [ <nixpkgs/pkgs/applications/editors/vim/cflags-prune.diff> ];

  configureFlags = [
    "--with-features=huge"

    "--enable-gui=${guiSupport}"
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
  ] ++ stdenv.lib.optional stdenv.isDarwin (if darwinSupport then "--enable-darwin" else "--disable-darwin")
    ++ stdenv.lib.optional netbeansSupport "--enable-netbeans"
  ;

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
