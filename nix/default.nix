let

  lib =
    let super = import <nixpkgs/lib>;
    in super // import ./lib { lib = super; };

  args = {
    crossSystem = null;
    overlays = [
      libOverlay
      (import ./overlay)
    ];
    config = import ./nixpkgs-config.nix;
  };

  module = { ... }: {
    imports = [
      (import ./modules)
    ] ++ externalModules;
    config = {
      nixpkgs = args;
    };
  };

  combine =
    { crossSystem ? null
    , overlays ? []
    , config ? {}
    }:
    args: args // {
      crossSystem = if crossSystem == null then args.crossSystem else crossSystem;
      overlays = args.overlays ++ overlays;
      config = args.config // config;
    };

  libOverlay = self: super: {
    lib = super.lib // import ./lib { inherit (super) lib; };
  };

  envOverlay = self: super: with self; with lib; {
    env = self.buildEnv {
      name = "env";
      pathsToLink = [
        "/"
        "/share/dotfiles"
      ];
      paths = concatMap (path: import path self) ([
        ./env
      ] ++ lib.concatMap (lib.optionalPath "/env.nix") [
        "local"
        "private"
      ]);
    };
  };

  externalModules = lib.concatMap (lib.optionalPath "/config.nix") [
    "local"
    "private"
  ];

  externalOverlays = lib.concatMap (lib.optionalPath "/overlay.nix") [
    "local"
    "private"
  ];

in {

  inherit lib;

  pkgs = lib.makeOverridableWith combine (args: import <nixpkgs> args) (combine {
    overlays = externalOverlays ++ [ envOverlay ];
  } args);

  nixos = lib.makeOverridableWith
    (module: modules: modules ++ [ module ])
    (modules: import <nixpkgs/nixos> { configuration.imports = modules; })
    [ module ];

}
