pkgs: with pkgs; [

# ghc
(haskellPackages.ghcWithPackages (import ../lists/hp.nix))
haskellPackages.cabal-install
cabal2nix

# other languages
gcc
python27
python34
jdk
chuck

# doc prep

haskell.packages.ghc7102.pandoc

(texlive.combine {
  inherit (texlive)
    scheme-small
    collection-latexextra
    # pbox
    # csquotes
    # beamerposter
    # type1cm
  ;
})

]
