{ stdenv, fetchgit, lightdm, dbus_glib, gtk3, webkitgtk, ninja, pkgconfig, gettext, meson, glib, lib, makeWrapper, xorg }:

let inherit (xorg) libX11;

in stdenv.mkDerivation rec {

  name = "lightdm-webkit2-greeter-2.2.3";

  src = fetchgit {
    url = "https://github.com/Antergos/lightdm-webkit2-greeter.git";
    rev = "06c0927cb2eea41db603876f6bceeb638dd6c516";
    sha256 = "14w9ha69b1hs31ynl3ncc00y4yrrk58zhl8n19931bp5z50477ww";
  };

  buildInputs = [
    lightdm dbus_glib gtk3 webkitgtk meson ninja
    pkgconfig xorg.libX11 glib
    gettext makeWrapper
  ];

  libPath = stdenv.lib.makeLibraryPath buildInputs;

  patches = [ ./lang.patch ];

  configurePhase = ''
    patchShebangs .
    cd build
    meson.py --prefix="$out" \
      -Dwith-theme-dir=$out/share/lightdm-webkit/themes \
      -Dwith-config-dir=$out/etc/lightdm \
      -Dwith-desktop-dir=$out/share/xgreeters \
      -Dwith-webext-dir=$out/lib/lightdm-webkit2-greeter \
      -Dwith-locale-dir=$out/share/locale \
      ..
  '';

  buildPhase = ''
    ninja
  '';

  installPhase = ''
    ninja install
    wrapProgram $out/bin/lightdm-webkit2-greeter \
      --prefix LD_LIBRARY_PATH : ${libPath} \
  '';

}
