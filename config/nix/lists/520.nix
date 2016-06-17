pkgs: with pkgs; [

(haskellPackages.ghcWithPackages (import ../lists/hp.nix))
haskellPackages.cabal-install
cabal2nix

]
