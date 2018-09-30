{ stdenv, fetchgit }:

stdenv.mkDerivation {
  name = "chicago95-theme";
  src = fetchgit {
    url = "https://github.com/grassmunk/Chicago95";
    rev = "2f383092ce96a82ee358fc40a196a7ced53379fb";
    sha256 = "1pxzra35qhpnf0qwx6qkmyj3fwkwn7mmnl3jsc6aq444nr4mxs8c";
  };

  builder = builtins.toFile "builder.sh" ''
    . $stdenv/setup

    unpackPhase
    cd "$sourceRoot"

    sed -i "s|/usr|$out|" Plymouth/Chicago95/Chicago95.plymouth

    function copy() {
      mkdir -p $2
      cp -r $1 $2
    }

    copy Extras/override/gtk.css $out/etc/gtk-3.0
    copy Theme/Chicago95         $out/share/themes
    copy Icons/Chicago95         $out/share/icons
    copy Fonts/vga_font          $out/share/fonts/truetype
    copy Plymouth/Chicago95      $out/share/plymouth/themes
    # copy Lightdm/Chicago95       $out/share/lightdm-webkit/themes
    copy Lightdm/Chicago95       $out/share/web-greeter/themes

    for x in Cursors/*; do
      copy $x                    $out/share/icons
    done
  '';
}
