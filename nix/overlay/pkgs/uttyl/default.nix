{ stdenv, fetchgit }:

stdenv.mkDerivation {
  name = "uttyl";
  src = fetchgit {
    url = "https://github.com/nspin/uttyl.git";
    sha256 = "0g2isp930yrshs1b2l54nsswsrj0819di445f9ccigzkq9ab8j7n";
  };
  builder = builtins.toFile "builder.sh" ''
    source $stdenv/setup
    mkdir -p $out/bin
    gcc -lutil -o $out/bin/parpty $src/parpty.c
    gcc -o $out/bin/tmuxdo $src/tmuxdo.c
    cp $src/urxvtdo $out/bin/urxvtdo
    cp $src/tmuxtry $out/bin/tmuxtry
  '';
}
