{ stdenv, fetchgit }:

stdenv.mkDerivation {
  name = "uttyl";
  src = fetchgit {
    url = "https://github.com/nspin/uttyl.git";
    sha256 = "0g2isp930yrshs1b2l54nsswsrj0819di445f9ccigzkq9ab8j7n";
  };
  buildPhase = ''
    $CC -lutil -o parpty parpty.c
    $CC -o tmuxdo tmuxdo.c
  '';
  installPhase = ''
    install -D -t $out/bin parpty urxvtdo tmuxdo tmuxtry
  '';
}
