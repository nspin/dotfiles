{ pkgs }:

{

  allowUnfree = true;
  allowBroken = true;

  firefox.enableAdobeFlash = true;

  haskellPackageOverrides = self: super: with pkgs.haskell.lib; {

    # hakyll =
    #   let deps = with super; [
    #       snap-core
    #       snap-server
    #       fsnotify
    #       system-filepath
    #     ];
    #   in appendConfigureFlag (pkgs.lib.foldl' addBuildDepend super.hakyll deps) "-f previewServer -f watchServer";

    hakyll = dontCheck (self.callPackage ./local/hackage-packages/hakyll.nix {});

    xhb = appendPatch super.xhb ./local/hackage-packages/xhb.patch;
    # xhb = super.xhb.override { binary = self.binary_0_8_3_0; };
    # binary_0_8_3_0 = self.callPackage ./local/hackage-packages/binary_0_8_3_0.nix {};
    # binary = self.callPackage ./local/hackage-packages/binary_0_8_3_0.nix {};

    xhb-requests = (import ~/xhb/xhb-requests { inherit pkgs; }).xhb-requests;
    xhb-keysyms = (import ~/xhb/xhb-keysyms { inherit pkgs; }).xhb-keysyms;
    xhb-monad = self.callPackage ~/xhb/xhb-monad {};
    xhb-mapping-state = self.callPackage ~/xhb/xhb-mapping-state {};

  };

  packageOverrides = pkgs: with pkgs; {

    darwinEnv = pkgs.buildEnv {
      name = "darwinEnv";
      paths = pkgs.lib.concatMap (x: import x pkgs) [
        ../lists/core.nix
        ../lists/hs.nix
        ../lists/darwin/core.nix
      ];
    };

    mylib = callPackage ./lib {};

    vim-rtp = callPackage ./aux/vim-rtp {};
    # hscript = callPackage ./aux/hscript {};
    ghc-pkg-db = callPackage ./aux/ghc-pkg-db {};

    spotify-ripper = callPackage ./local/spotify-ripper {};
    ycm = callPackage ./local/ycm {};
    wicd = callPackage ./local/wicd {};
    mitmproxy = callPackage ./local/mitmproxy {};
    apktool = callPackage ./local/apktool {
      buildTools = androidenv.buildTools;
    };

    gophish = callPackage ./local/gophish {};

    opencvBloated = callPackage <nixpkgs/pkgs/development/libraries/opencv> {
      enableBloat = true;
    };

  };

}
