{ lib, ... }:

with lib;

let

  externalModules = concatMap (path: optional (pathExists path) path) [
    (<local> + /config.nix)
    (<private> + /config.nix)
  ];

in {

  imports = [
    ./pia
    ./env
    ./gui
  ] ++ externalModules;

  nixpkgs = {
    overlays = [
      (import ../overlay)
    ];
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

}

