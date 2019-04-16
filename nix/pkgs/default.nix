let

  core = import <core>;

  inherit (core) lib;

  envOverlay = self: super: with self; with lib; {
    env = self.buildEnv {
      name = "env";
      pathsToLink = [
        "/"
        "/share/dotfiles"
      ];
      paths = concatMap (path: import path self) ([
        ./env.nix
      ] ++ lib.concatMap (lib.optionalPath "/env.nix") [
        "local"
        "private"
      ]);
    };
  };

in core.pkgs.override {

  overlays = lib.concatMap (lib.optionalPath "/overlay.nix") [
    "local"
    "private"
  ] ++ [
    envOverlay
  ];

}
