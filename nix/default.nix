let

  lib =
    let super = import <nixpkgs/lib>;
    in super // import ./lib { lib = super; };

  args = {
    crossSystem = null;
    overlays = [
      (self: super: {
        lib = super.lib // import ./lib { inherit (super) lib; };
      })
      (import ./overlay)
    ];
    config = import ./config.nix;
  };

  module = { ... }: {
    imports = [
      (import ./modules)
    ];
    config = {
      nixpkgs = args;
    };
  };

  combine = args:
    { crossSystem ? null
    , overlays ? []
    , config ? {}
    }:
    args // {
      crossSystem = if crossSystem == null then args.crossSystem else crossSystem;
      overlays = args.overlays ++ overlays;
      config = args.config // config;
    };

in {

  inherit lib;

  pkgs = lib.makeOverridableWith combine (args: import <nixpkgs> args) args;

  nixos = lib.makeOverridableWith
    (module: modules: modules ++ [ module ])
    (modules: import <nixpkgs/nixos> { configuration.imports = modules; })
    [ module ];

}
