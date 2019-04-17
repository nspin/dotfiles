let

  fix = f: let x = f x; in x;

  lib = fix (self: let super = import <nixpkgs/lib>; in super // libExtension self super);

  libExtension = import ./lib;
  nixpkgsConfig = import ./nixpkgs-config.nix;

  internalModule = import ./modules;
  internalOverlay = import ./overlay;
  internalEnvPaths = import ./env;
  internalEnvPathsToLink = import ./env/paths-to-link.nix;

  externalModules = lib.tryImports "/config.nix" externalBases;
  externalOverlays =  lib.tryImports "/overlay.nix" externalBases;
  externalEnvPaths = lib.tryImports "/env.nix" externalBases;
  externalEnvPathsToLink = lib.tryImports "/env-paths-to-link.nix" externalBases;

  externalBases = [
    "local"
    "private"
  ];

  libOverlay = self: super: {
    lib = fix (lself: let lsuper = super.lib; in lsuper // libExtension lself lsuper);
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

in rec {

  inherit lib libOverlay;

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
