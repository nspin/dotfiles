{ pkgs }: {

  allowUnfree = true;
  allowBroken = true;

  packageOverrides = import ./pkgs;

  haskellPackageOverrides = self: super: with pkgs.haskell.lib; {
    minibar = self.callPackage /home/nick/repos/minibar {};
  };

}
