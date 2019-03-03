{ lib, callPackage, stdenv }:

let

  extra = callPackage ./extra.nix {};

  mk = name: src: stdenv.mkDerivation ({

    phases = [ "unpackPhase" "patchPhase" "installPhase" ];

    inherit name src;

    installPhase = ''
      runHook preInstall

      dst=$out/share/vim-bundle/$name
      mkdir -p $dst
      cp -r * $dst

      runHook postInstall
    '';

  } // (extra.${name} or {}));


in rec {

  vim-plugins = lib.mapAttrs mk (removeAttrs (callPackage ./srcs.nix {}) [ "override" "overrideDerivation" ]); # dancing with devil

  vim-plugins-all = lib.attrValues vim-plugins;

  vim-plugins-excluding = names: lib.attrValues (lib.filterAttrs (k: v: !(lib.elem k names)) vim-plugins);
}
