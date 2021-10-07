{ writeScript
, runtimeShell
, linkFarm
, lib
, stdenv
, zlib, libuv, openssl, icu58
}:

linkFarm "patch-vscode" [
  { name = "bin/patch-vscode";
    path = writeScript "patch-vscode" ''
      #!${runtimeShell}
      set -eu
      for hash in "$@"; do
        patchelf $hash/node \
          --set-interpreter "$(cat ${stdenv.cc}/nix-support/dynamic-linker)" \
          --set-rpath ${lib.concatStringsSep ":" (map (path: "${lib.getLib path}/lib") [
            stdenv.cc.cc
            stdenv.glibc
            zlib
            libuv
            openssl
            icu58
          ])}
      done
    '';
  }
]

#  patchelf 08a217c4d27a02a5bcde898fd7981bda5b49391b/node

# --set-interpreter
# /nix/store/9df65igwjmf2wbw0gbrrgair6piqjgmi-glibc-2.31/lib/ld-linux-x86-64.so.2

# --set-rpath
# /nix/store/9sfmwj09ij65qnc8dgv8h56gf12b60nn-zlib-1.2.11/lib:
# /nix/store/3c9b59p36qq8g2dxaa70k6l1gy9cxr72-libuv-1.38.1/lib:
# /nix/store/aqafh2kgahm2hv3nkihmgnvsg7y4ihcj-openssl-1.1.1g/lib:
# /nix/store/dr20b66cz7xya8gwkqpv8yz53k55dy54-icu4c-67.1/lib:
# /nix/store/9df65igwjmf2wbw0gbrrgair6piqjgmi-glibc-2.31/lib:
# /nix/store/vran8acwir59772hj4vscr7zribvp7l5-gcc-9.3.0-lib/lib
