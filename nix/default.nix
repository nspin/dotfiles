let

  lib = let lib0 = import <nixpkgs/lib>; in lib0.fix (lib0.extends (import ./lib) (lib0.const lib0));

  nixpkgsConfig = import ./nixpkgs-config.nix;

  internalModule = import ./modules;
  internalOverlay = import ./overlay;
  internalEnvPaths = import ./env;
  internalEnvPathsToLink = import ./env/paths-to-link.nix;

  externalModules = tryImports "/config.nix" externalBases;
  externalOverlays =  tryImports "/overlay.nix" externalBases;
  externalEnvPaths = tryImports "/env.nix" externalBases;
  externalEnvPathsToLink = tryImports "/env-paths-to-link.nix" externalBases;

  externalBases = [
    "local"
    "private"
  ];

  libOverlay = self: super: {
    inherit lib;
  };

  envOverlay = self: super: {
    env = self.buildEnv {
      name = "env";
      pathsToLink = internalEnvPathsToLink ++ lib.concatLists externalEnvPathsToLink;
      paths = lib.concatMap (env: env self) ([ internalEnvPaths ] ++ externalEnvPaths);
    };
  };

  nixpkgsModule = { ... }: {
    config = {
      nixpkgs = {
        overlays = [
          libOverlay
          internalOverlay
        ];
        config = nixpkgsConfig;
      };
    };
  };

  combineNixpkgsArgs =
    { crossSystem ? null
    , overlays ? []
    , config ? {}
    }:
    args: args // {
      crossSystem = if crossSystem == null then args.crossSystem else crossSystem;
      overlays = args.overlays ++ overlays;
      config = args.config // config;
    };

  # helpers

  tryImports = suffix: bases: map import (lib.concatMap (optionalPath suffix) bases);

  optionalPath = suffix: base: lib.optionals (lib.hasAttr base lib.nixPathAttrs) (
    let path = builtins.toPath (lib.nixPathAttrs.${base} + suffix);
    in lib.optional (lib.pathExists path) path
  );

in rec {

  inherit lib;

  pkgs = lib.makeOverridableWith combineNixpkgsArgs (args: import <nixpkgs> args) {
    crossSystem = null;
    overlays = [
      libOverlay
      internalOverlay
    ] ++ externalOverlays ++ [
      envOverlay
    ];
    config = nixpkgsConfig;
  };

  nixos = lib.makeOverridableWith
    (module: modules: modules ++ [ module ])
    (modules: import <nixpkgs/nixos> { configuration.imports = modules; })
    ([ internalModule nixpkgsModule ] ++ externalModules);

  inherit (nixos.config.system) build;

}
