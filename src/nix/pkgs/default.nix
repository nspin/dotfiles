pkgs: with pkgs; {

  mylib = callPackage ./lib {};

  vim-rtp = callPackage ./aux/vim-rtp {};
  hscript = callPackage ./aux/hscript {};
  ghc-pkg-db = callPackage ./aux/ghc-pkg-db {};

  ycm = callPackage ./local/ycm {};
  mars = callPackage ./local/mars {};
}

