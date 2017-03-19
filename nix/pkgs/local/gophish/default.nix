{ stdenv, fetchzip }:

stdenv.mkDerivation rec {

  name = "gophish-${version}";
  version = "v0.1.2";

  src = fetchzip {
    url = "https://github.com/gophish/gophish/releases/download/v0.1.2/gophish_linux_64bit.zip";
    sha256 = "1f5apjhdi0ncxl0x2j7j69qcmsrzqv06k65xjhswbzyz46ch4vz7";
  };

  installPhase = ''
    cp ${src}/gophish .
    chmod +x gophish
    patchelf --set-interpreter ${stdenv.glibc}/lib64/ld-linux-x86-64.so.2 gophish
    mkdir -p $out/bin
    mv gophish $out/bin
  '';

}
