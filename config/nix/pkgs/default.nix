pkgs: with pkgs; {

  mylib = callPackage ./lib {};

  vim-rtp = callPackage ./aux/vim-rtp {};
  hscript = callPackage ./aux/hscript {};
  ghc-pkg-db = callPackage ./aux/ghc-pkg-db {};

  ycm = callPackage ./local/ycm {};

  opencv3Huge = callPackage (<nixpkgs> + /pkgs/development/libraries/opencv/3.x.nix) {
    enableContrib = true;
    enableBloat = true;
  };
}

