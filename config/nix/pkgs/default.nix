pkgs: with pkgs; {

  mylib = callPackage ./lib {};

  vim-rtp = callPackage ./aux/vim-rtp {};
  hscript = callPackage ./aux/hscript {};
  ghc-pkg-db = callPackage ./aux/ghc-pkg-db {};

  ycm = callPackage ./local/ycm {};
  wicd = callPackage ./local/wicd {};
  mitmproxy = callPackage ./local/mitmproxy {};
  apktool = callPackage ./local/apktool {
    buildTools = androidenv.buildTools;
  };

  opencvBloated = callPackage <nixpkgs/pkgs/development/libraries/opencv> {
    enableBloat = true;
  };
}

