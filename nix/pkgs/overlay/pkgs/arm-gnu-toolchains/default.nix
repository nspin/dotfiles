{ stdenv, fetchurl, ncurses5, python27, zlib, glibc }:

let

  mk = { name, src }:
    stdenv.mkDerivation rec {
      inherit name src;
      phases = [ "unpackPhase" "installPhase" ];
      # phases = [ "unpackPhase" "installPhase" "fixupPhase" ];
      installPhase = ''
        cp -r . $out
        find $out -type f | while read f; do
          patchelf $f > /dev/null 2>&1 || continue
          patchelf --set-interpreter $(cat ${stdenv.cc}/nix-support/dynamic-linker) "$f" > /dev/null 2>&1 || true
        done
      '';
          # patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ "$out" stdenv.cc.cc ncurses5 python27 ]} "$f" || true
          # patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ "$out" stdenv.cc.cc ncurses5 python27 zlib glibc ]} "$f" || true
    };

in {

  aarch64 = mk rec {
    name = "gcc-arm-8.2-2018.08-x86_64-aarch64-linux-gnu";
    src = fetchurl {
      name = "${name}.tar.xz";
      url = "https://developer.arm.com/-/media/Files/downloads/gnu-a/8.2-2018.08/${name}.tar.xz?revision=51f15dd6-02e2-4565-8619-12f29ff59ee7";
      sha256 = "13v4hm7ngnf8f8942d7zjp7pnpscsqcs6wddb0z6jq5c8r468q1y";
    };
  };

  aarch32 = mk rec {
    name = "gcc-arm-8.2-2018.08-x86_64-arm-linux-gnueabihf";
    src = fetchurl {
      name = "${name}.tar.xz";
      url = "https://developer.arm.com/-/media/Files/downloads/gnu-a/8.2-2018.08/${name}.tar.xz?revision=51f3ba22-a569-4dda-aedc-7988690c3c17";
      sha256 = "1f9rnk0j8ng9frxf7x0z32a7ygpk2lyvv9a5wmrk1p3y6bhj0gsv";
    };
  };

}
