{ stdenv, fetchurl, lightdm, pkgconfig, intltool
, makeWrapper
, gtk3
, webkitgtk24x
, dbus_glib
, gobjectIntrospection
, gnome_doc_utils
}:

stdenv.mkDerivation rec {
  name = "lightdm-webkit-greeter-2.0.0";

  src = fetchurl {
    url = "https://launchpad.net/lightdm-webkit-greeter/trunk/2.0.0/+download/lightdm-webkit-greeter-2.0.0.tar.gz";
    sha256 = "1avyd1p1yfhm3af4ds139gz38c0j1xvql3jafjfcjmjmr796hl4q";
  };

  buildInputs = [
    webkitgtk24x
    dbus_glib
    gtk3
    pkgconfig lightdm intltool makeWrapper
  ];

  configureFlags = [
    # "--localstatedir=/var"
    # "--sysconfdir=/etc"
    "--with-desktop-dir=\${out}/share/xgreeters"
    "--with-config-dir=\${out}/etc/lightdm"
    "--with-theme-dir=\${out}/share/lightdm-webkit/themes"
  ];

  installFlags = [
    "etcdir=\${out}/etc/lightdm"
    # "localstatedir=\${TMPDIR}"
    # "sysconfdir=\${out}/etc"
    # "desktopdir=\${out}/wat"
    # "configdir=\${out}/foo"
  ];

  postInstall = ''
    substituteInPlace "$out/share/xgreeters/lightdm-webkit-greeter.desktop" \
      --replace "Exec=lightdm-webkit-greeter" "Exec=$out/bin/lightdm-webkit-greeter"
  '';
    # wrapProgram "$out/sbin/lightdm-gtk-greeter" \
    #   --prefix XDG_DATA_DIRS ":" "${hicolor_icon_theme}/share"

}
