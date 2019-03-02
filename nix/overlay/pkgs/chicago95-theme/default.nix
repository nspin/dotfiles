{ stdenv, fetchgit }:

stdenv.mkDerivation {
  name = "chicago95-theme";
  src = fetchgit {
    url = "https://github.com/grassmunk/Chicago95";
    rev = "2f383092ce96a82ee358fc40a196a7ced53379fb";
    sha256 = "1pxzra35qhpnf0qwx6qkmyj3fwkwn7mmnl3jsc6aq444nr4mxs8c";
  };

  patchPhase = ''
    sed -i "s,/usr,$out," Plymouth/Chicago95/Chicago95.plymouth
  '';

  installPhase = ''
    function copy() {
      d=$1; shift
      mkdir -p $d
      cp -r "$@" $d
    }

    copy $out/etc/gtk-3.0                  Extras/override/gtk.css
    copy $out/share/themes                 Theme/Chicago95
    copy $out/share/icons                  Icons/Chicago95
    copy $out/share/fonts/truetype         Fonts/vga_font
    copy $out/share/plymouth/themes        Plymouth/Chicago95
    copy $out/share/lightdm-webkit/themes  Lightdm/Chicago95
    copy $out/share/web-greeter/themes     Lightdm/Chicago95
    copy $out/share/icons                  Cursors/*
  '';
}
