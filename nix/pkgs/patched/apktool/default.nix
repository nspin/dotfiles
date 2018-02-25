{ stdenv, fetchurl, makeWrapper, jre, buildTools }:

stdenv.mkDerivation rec {
  name = "apktool-${version}";
  version = "2.1.1";

  src = fetchurl {
    url = "https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_${version}.jar";
    sha256 = "14n2f5xhzsm3c76n8c14gxgifv1yh82bhycx7j7pf7hzmqya5hj8";
  };

  phases = [ "installPhase" ];

  buildInputs = [ makeWrapper ];

  sourceRoot = ".";

  installPhase = ''
    install -D ${src} "$out/libexec/apktool/apktool.jar"
    mkdir -p "$out/bin"
    makeWrapper "${jre}/bin/java" "$out/bin/apktool" \
        --add-flags "-jar $out/libexec/apktool/apktool.jar" \
        --prefix PATH : "${buildTools}/build-tools/android-4.3/"
  '';

  meta = with stdenv.lib; {
    description = "A tool for reverse engineering Android apk files";
    homepage    = https://code.google.com/p/android-apktool/;
    license     = licenses.asl20;
    maintainers = with maintainers; [ offline ];
  };

}
