# only for non-nixos

let

  tryOverlay = path: self: super:
    if super.lib.pathExists path
    then import path self super
    else {};

  darwinEnvOverlay = self: super: {
    darwin-env = self.buildEnv {
      name = "darwin-env";
      paths =
        let
          try = path: if self.lib.pathExists path then import path self else [];
        in import ./darwin-env.nix self
          ++ try (<local> + /env.nix)
          ++ try (<private> + /env.nix);
    };
  };

in import <nixpkgs> {
  config = import ./config.nix;
  overlays = [
    (import ./overlay)
    darwinEnvOverlay
    (tryOverlay (<local> + /overlay.nix))
    (tryOverlay (<private> + /overlay.nix))
  ];
}
