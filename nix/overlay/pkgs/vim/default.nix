{ stdenv, lib, fetchFromGitHub

, gettext, pkgconfig, perl
, ncurses, python3, ruby, lua

, libX11, libXext, libSM, libXpm, libXt, libXaw, libXau, libXmu, glib, libICE
, gtk3, gtk2

, CoreServices, CoreData, Cocoa, Foundation, libobjc, cf-private

, guiSupport ? "no"
, netbeansSupport ? true
, darwinSupport ? stdenv.isDarwin
}:

stdenv.mkDerivation rec {
  name = "vim-${version}";
  version = "8.1.1967";
  src = fetchFromGitHub {
    owner = "vim";
    repo = "vim";
    rev = "v${version}";
    sha256 = "0cdfi67jwv8j982i1jxdfqv4aqglig8f0hzadgygk69i0wwkymwk";
  };

  enableParallelBuilding = true;
  hardeningDisable = [ "fortify" ];

  # Use man from $PATH; escape sequences are still problematic.
  postPatch = ''
    substituteInPlace runtime/ftplugin/man.vim \
      --replace "/usr/bin/man " "man "
  '';

  patches = [
    ./cflags-prune.patch
  ];

  nativeBuildInputs = [ gettext pkgconfig perl ];
  buildInputs = [
    ncurses python3 ruby lua
  ] ++ lib.optionals stdenv.isDarwin [
    CoreServices CoreData Cocoa Foundation libobjc cf-private
  ] ++ lib.optionals (!stdenv.isDarwin && guiSupport != "no") [
    libX11 libXext libSM libXpm libXt libXaw libXau libXmu glib libICE
    (if guiSupport == "gtk3" then gtk3 else gtk2)
  ];

  configureFlags = [
    "--with-features=huge"

    "--enable-gui=${guiSupport}"
    "--enable-multibyte"
    "--enable-nls"
    "--enable-cscope"

	"--enable-mzschemeinterp"
	"--enable-python3interp"

    # TODO broken
	# "--enable-perlinterp"
	"--disable-perlinterp"

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

}
