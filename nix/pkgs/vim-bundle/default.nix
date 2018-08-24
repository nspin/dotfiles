{ lib, callPackage, stdenv, fetchgit }:

let

  extra = callPackage ./extra.nix {};

  mkDrv = { name, src }: stdenv.mkDerivation ({
    inherit name src;
    builder = builtins.toFile "builder.sh" ''
      . $stdenv/setup
      d=$out/share/vim-bundle
      mkdir -p $d
      root=$d/${name}
      cp -r $src $root
      cd $root
      $extra
    '';
  # } // (if lib.hasAttr name extra then lib.getAttr name extra else {});
  } //  lib.getAttr name extra);

  mk = lib.mapAttrs (name: value: mkDrv {
    inherit name;
    src = value;
  });

in mk (callPackage ./srcs.nix {})
