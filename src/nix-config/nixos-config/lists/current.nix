pkgs: with pkgs; [

# ghc
/* local.my-ghc */
/* haskellPackages.cabal2nix */
cabal2nix

local.mars
/* local.mips-init */

# java bullshit
/* jdk */
#maven

# other languages
/* gcc */
/* clang */
#mitscheme
#racket
#nodejs
python27
/* python34 */

# doc prep
#haskell.packages.ghc7102.pandoc
#(texLiveAggregationFun { paths = [ texLive texLiveExtra texLiveBeamer lmodern ]; })

]
