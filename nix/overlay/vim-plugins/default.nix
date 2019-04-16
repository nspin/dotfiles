{ lib, callPackage, stdenv, fetchgit }:

let

  extra = callPackage ./extra.nix {};

  mk = name: value: stdenv.mkDerivation ({

    inherit name;
    src = fetchgit (removeAttrs value [ "date" ]);

    phases = [ "unpackPhase" "patchPhase" "installPhase" ];

    installPhase = ''
      runHook preInstall

      dst=$out/share/vim-bundle/$name
      mkdir -p $dst
      cp -r * $dst

      runHook postInstall
    '';

  } // (extra.${name} or {}));


in rec {

  vim-plugins = lib.mapAttrs mk (builtins.fromJSON (builtins.readFile ./srcs.json));

  vim-plugins-all = lib.attrValues vim-plugins;

  vim-plugins-excluding = names: lib.attrValues (lib.filterAttrs (k: v: !(lib.elem k names)) vim-plugins);

}
