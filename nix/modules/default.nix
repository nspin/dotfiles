{ lib, ... }:

with lib;

let

  # TODO fix lib
  nixPathAttrs = listToAttrs (map ({ prefix, path }: { name = prefix; value = path; }) builtins.nixPath);

  externalModules =
    let
      f = base: optionals (hasAttr base nixPathAttrs) (
        let path = nixPathAttrs.${base} + "/config.nix";
        in optional (pathExists path) (builtins.toPath path)
      );
    in concatMap f [
      "local"
      "private"
    ];

in {

  imports = [
    ./pia
    ./env
    ./gui
    ./user
    ./headless
    ./misc
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
