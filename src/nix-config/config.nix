{ pkgs }:

{
  haskellPackageOverrides = with pkgs.haskell.lib; self: super: {
    # ghcjs = pkgs.haskell.packages.ghcjs.ghc.override { vector = ./local/vector_0_11_0_0.nix; };
  };

  packageOverrides = pkgs: rec {
  };
}
