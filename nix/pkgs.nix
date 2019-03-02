let

  tryOverlay = path: self: super: with self; with lib;
    optionalAttrs (pathExists path) (import path self super);

  envOverlay = self: super: with self; with lib; {
    env = self.buildEnv {
      name = "env";
      paths =
        let
          try = path: optionals (pathExists path) (import path self);
        in [
          (try ./darwin-env.nix)
          (try (<local> + /env.nix))
          (try (<private> + /env.nix))
        ];
    };
  };

in import <nixpkgs> {

  overlays = [
    (import ./overlay)
    (tryOverlay (<local> + /overlay.nix))
    (tryOverlay (<private> + /overlay.nix))
    envOverlay
  ];

  config = {
    allowUnfree = true;
    allowBroken = true;
  };

}
