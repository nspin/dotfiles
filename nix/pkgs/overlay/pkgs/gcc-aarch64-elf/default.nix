{ stdenv, fetchurl, ncurses5, python27, zlib, glibc }:

stdenv.mkDerivation rec {

  name = "gcc-linaro-4.9-aarch64-elf";

  src = fetchurl {
    url = "https://releases.linaro.org/archive/14.11/components/toolchain/binaries/aarch64-none-elf/gcc-linaro-4.9-2014.11-x86_64_aarch64-elf.tar.xz";
    sha256 = "1x2vl7r9vhd1d5q9qxg682s6d9khv3lq5vr78zlclzg3jcrr8yp0";
  };

  phases = [ "unpackPhase" "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';

  dontPatchELF = true;
  dontStrip = true;

  preFixup = ''
    find $out -type f | while read f; do
      patchelf $f > /dev/null 2>&1 || continue
      patchelf --set-interpreter $(cat ${stdenv.cc}/nix-support/dynamic-linker) "$f" || true
      # patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ "$out" stdenv.cc.cc ncurses5 python27 ]} "$f" || true
      patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ "$out" stdenv.cc.cc ncurses5 python27 zlib glibc ]} "$f" || true
    done
  '';

}
