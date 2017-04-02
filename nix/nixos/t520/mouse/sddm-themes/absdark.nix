{ stdenv, fetchgit }:

stdenv.mkDerivation {
  name = "sddm-theme-absdark";
  src = fetchgit {
    url = "https://github.com/3ximus/abstractdark-sddm-theme.git";
    rev = "e817d4b27981080cd3b398fe928619ffa16c52e7";
    sha256 = "1si141hnp4lr43q36mbl3anlx0a81r8nqlahz3n3l7zmrxb56s2y";
    fetchSubmodules = true;
  };
  builder = builtins.toFile "builder.sh" ''
    . $stdenv/setup
    mkdir -p $out/share/sddm/themes
    cp -r $src $out/share/sddm/themes/absdark
  '';
}
