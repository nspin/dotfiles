{ stdenv, fetchgit, gtk3 }:

stdenv.mkDerivation {
  name = "chicago95-theme";
  src = fetchgit {
    url = "https://github.com/grassmunk/Chicago95";
    rev = "55a77c4750a8fdae983ccbc976f4ab8634983299";
    sha256 = "1q537p4nxyz9nhwcfhixrn9akyah8kxq1nxxq43xpjb1qxj61jwp";
  };

  nativeBuildInputs = [ gtk3 ];

  # patchPhase = ''
  #   sed -i "s,/usr,$out," Plymouth/Chicago95/Chicago95.plymouth
  # '';

  installPhase = ''
    function copy() {
      d=$1; shift
      mkdir -p $d
      cp -r "$@" $d
    }

    copy $out/share/themes                 Theme/Chicago95
    copy $out/share/icons                  Icons/Chicago95
    copy $out/share/icons                  Cursors/Chicago95*
  '';
    # copy $out/share/plymouth/themes        Plymouth/Chicago95
    # copy $out/share/lightdm-webkit/themes  Lightdm/Chicago95
    # copy $out/share/web-greeter/themes     Lightdm/Chicago95
    # copy $out/share/fonts/truetype         Fonts/vga_font
    # copy $out/etc/gtk-3.0                  Extras/override/gtk.css

  postFixup = ''
    for theme in $out/share/icons/*; do
      gtk-update-icon-cache $theme
    done
  '';

}
