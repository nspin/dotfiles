pkgs: with pkgs; [

# school
local.mars

# ghc

local.my-ghc
haskellPackages.cabal-install
cabal2nix

# java bullshit

jdk
# maven
# idea.idea-community
chuck

# chuck

# other languages

# gcc
# clang
# mitscheme
# racket
# nodejs
python27
python34

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
