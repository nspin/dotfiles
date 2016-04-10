{ pkgs }: {
  allowUnfree = true;
  haskellPackageOverrides = with pkgs.haskell.lib; self: super: {};
  packageOverrides = import ./pkgs;
}
