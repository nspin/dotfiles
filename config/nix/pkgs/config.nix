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

    http-client-tls_0_3_3 = super.http-client-tls_0_3_3.override { http-client = self.http-client_0_5_3_3; };

  };

  packageOverrides = super: let self = super.pkgs; in with self; {

    darwinEnv = buildEnv {
      name = "darwinEnv";
      paths = lib.concatMap (x: import x self) [
        ../lists/core.nix
        ../lists/math.nix
        ../lists/darwin/core.nix
        ../lists/darwin/extra.nix
        ../lists/carve_mac.nix
      ];
    };

    mylib = callPackage ./lib {};

    ghc-pkg-db = callPackage ./aux/ghc-pkg-db {};

    spotify-ripper = callPackage ./local/spotify-ripper {};

    mitmproxy = callPackage ./local/mitmproxy {};
    apktool = callPackage ./local/apktool {
      buildTools = androidenv.buildTools;
    };

    gophish = callPackage ./local/gophish {};

    readme_preview = callPackage ./local/grip {};

    # vim-rtp = callPackage ./aux/vim-rtp {};
    # hscript = callPackage ./aux/hscript {};

    # ycm = recurseIntoAttrs (callPackage ./local/ycm {
    #   inherit (darwin.apple_sdk.frameworks) Cocoa;
    #   llvmPackages = llvmPackages_39;
    # });

    # wicd = callPackage ./local/wicd {};

    # opencvBloated = callPackage <nixpkgs/pkgs/development/libraries/opencv> {
    #   enableBloat = true;
    # };

    my-vim = vimUtils.makeCustomizable (callPackage <nixpkgs/pkgs/applications/editors/vim/configurable.nix> {
      inherit (darwin.apple_sdk.frameworks) CoreServices Cocoa Foundation CoreData;
      inherit (darwin) libobjc cf-private;

      features = "huge"; # one of  tiny, small, normal, big or huge
      lua = lua5_1;
      gui = config.vim.gui or "auto";

      # optional features by flags
      flags = [ "python" "X11" ]; # only flag "X11" by now

      python = python.buildEnv.override {
        extraLibs = [ pythonPackages.pycrypto ];
      };

    });

  };

}
