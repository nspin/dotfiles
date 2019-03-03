with import <nixpkgs/lib>;

let

  tryOverlay = path: self: super:
    # with self.lib;
    optionalAttrs (pathExists path) (import path self super);

  envOverlay = self: super: with self; with lib; {
    env = self.buildEnv {
      name = "env";
      paths = concatMap (path: import path self) ([
        ./env.nix
      ] ++ filter pathExists [
        (<local> + /env.nix)
        (<private> + /env.nix)
      ]);
    };
  };

in import <nixpkgs> {

  overlays = [
    (import ../overlay)
    (tryOverlay (<local> + /overlay.nix))
    (tryOverlay (<private> + /overlay.nix))
    envOverlay
  ];

  config = {
    allowUnfree = true;
    allowBroken = true;
  };

}
