{ stdenv, fetchurl, lightdm, pkgconfig, intltool
, hicolor_icon_theme, makeWrapper
, gtk3
# , useGTK2 ? false, gtk2, gtk3 # gtk3 seems better supported
, webkitgtk24x
, dbus_glib
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
    pkgconfig lightdm intltool makeWrapper ];
    # ++ (if useGTK2 then [ gtk2 ] else [ gtk3 ]);

  configureFlags = [
    "--localstatedir=/var"
    "--sysconfdir=/etc"
  # ] ++ stdenv.lib.optional useGTK2 "--with-gtk2";
  ];

  installFlags = [
    "localstatedir=\${TMPDIR}"
    "sysconfdir=\${out}/etc"
  ];

  # postInstall = ''
  #   substituteInPlace "$out/share/xgreeters/lightdm-gtk-greeter.desktop" \
  #     --replace "Exec=lightdm-gtk-greeter" "Exec=$out/sbin/lightdm-gtk-greeter"
  #   wrapProgram "$out/sbin/lightdm-gtk-greeter" \
  #     --prefix XDG_DATA_DIRS ":" "${hicolor_icon_theme}/share"
  # '';

}
