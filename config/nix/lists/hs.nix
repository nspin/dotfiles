pkgs: with pkgs; [

ghc
# (haskellPackages.ghcWithPackages (import ../lists/hp.nix))
haskellPackages.cabal-install

cabal2nix

]
