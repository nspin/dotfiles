{ stdenv, fetchgit }:

stdenv.mkDerivation {
  name = "chicago95-theme";
  src = fetchgit {
    url = "https://github.com/grassmunk/Chicago95";
    rev = "38b53f266d743aa4f4bce57432dc060e2cbddc45";
    sha256 = "1pl6r9b9c3gsz8rl6m8a4xb9czjv7wv47n0avpfxjys02hy2kr2c";
  };
  builder = builtins.toFile "builder.sh" ''
    . $stdenv/setup
    mkdir -p $out/share/themes
    mkdir -p $out/share/icons
    mkdir -p $out/share/fonts/truetype
    mkdir -p $out/share/plymouth/themes
    cp -r $src/Theme/Chicago95 $out/share/themes
    cp -r $src/Icons/Chicago95 $out/share/icons
    cp -r $src/Cursors/* $out/share/icons
    cp -r $src/Fonts/vga_font $out/share/fonts/truetype
    cp -r $src/Plymouth/Chicago95 $out/share/plymouth/themes
  '';
}
