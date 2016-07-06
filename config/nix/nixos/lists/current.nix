pkgs: with pkgs; [

rtorrent
gimp

# ghc
(haskellPackages.ghcWithPackages (import ../lists/hp.nix))
haskellPackages.cabal-install
cabal2nix

# other languages
jdk
chuck

# doc prep

haskell.packages.ghc7102.pandoc

#(texlive.combine {
#  inherit (texlive)
#    scheme-small
#    collection-latexextra
#    collection-fontsrecommended
#    # pbox
#    # csquotes
#    # beamerposter
#    # type1cm
#  ;
#})

]
