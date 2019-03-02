{ lib, ... }:

with lib;

{

  imports =
    let
      try = path: optional (pathExists path) path;
    in import ./modules
      ++ (try (<local> + /config.nix))
      ++ (try (<private> + /config.nix))
      ;

  nixpkgs = {
    overlays = [
      (import ./overlay)
    ];
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

}
