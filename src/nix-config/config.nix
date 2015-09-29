{ pkgs }:

{
  haskellPackageOverrides = with pkgs.haskell.lib; self: super: {
    vector_0_11_0_0 = dontCheck super.vector_0_11_0_0;
    # ghcjs = pkgs.haskell.packages.ghcjs.ghc.override { vector = ./local/vector_0_11_0_0.nix; };
  };

  packageOverrides = pkgs: rec {
  };
}
