{ pkgs }: {

  allowUnfree = true;
  allowBroken = true;

  packageOverrides = pkgs: (import ./pkgs pkgs) // {
    foo = pkgs.fzf;
    darwinEnv = pkgs.buildEnv {
      name = "darwinEnv";
      paths = pkgs.lib.concatMap (x: import x pkgs) [
        ./lists/core.nix
        ./lists/hs.nix
        ./lists/darwin/core.nix
      ];
    };
  };

  haskellPackageOverrides = self: super: with pkgs.haskell.lib; {
    # minibar = self.callPackage /home/nick/repos/minibar {};
  };

}
