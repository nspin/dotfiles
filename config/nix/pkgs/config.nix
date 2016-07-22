{ pkgs }: {

  allowUnfree = true;
  allowBroken = true;

  haskellPackageOverrides = self: super: with pkgs.haskell.lib; {

    # xhb-requests = (import ~/xhb/xhb-requests { nixpkgs = pkgs; }).xhb-requests;
    # xhb-keysyms = self.callPackage ~/xhb/xhb-keysyms;

  };

  packageOverrides = pkgs: with pkgs; {
    foo = pkgs.fzf;
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
