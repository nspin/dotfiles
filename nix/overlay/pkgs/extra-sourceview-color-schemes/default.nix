{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "extra-sourceview-color-schemes";
  src = fetchFromGitHub {
    owner = "trusktr";
    repo = "gedit-color-schemes";
    rev = "4f62aae8abfa5175e0a9bd083e4f815bb6ff7a06";
    sha256 = "1b956qxz4nwfccmsfdn8kgdjl07amisxhwh0mskr2migm7crlc44";
  };
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    dst=$out/share
    mkdir -p $dst
    mv * $dst
  '';
}
