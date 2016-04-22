{ pkgs }: {
  allowUnfree = true;
  allowBroken = true;
  haskellPackageOverrides = with pkgs.haskell.lib; self: super: {};
  packageOverrides = import ./pkgs;
}
