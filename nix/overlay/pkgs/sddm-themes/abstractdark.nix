{ stdenv, fetchgit }:

stdenv.mkDerivation {
  name = "sddm-theme-abstractdark";
  src = fetchgit {
    url = "https://github.com/3ximus/abstractdark-sddm-theme.git";
    rev = "e817d4b27981080cd3b398fe928619ffa16c52e7";
    sha256 = "1si141hnp4lr43q36mbl3anlx0a81r8nqlahz3n3l7zmrxb56s2y";
    fetchSubmodules = true;
  };
  installPhase = ''
    cd $NIX_BUILD_TOP
    mkdir -p $out/share/sddm/themes
    mv $sourceRoot $out/share/sddm/themes/abstractdark
  '';
}
