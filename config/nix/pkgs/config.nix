{ pkgs }:

{

  allowUnfree = true;
  allowBroken = true;

  firefox.enableAdobeFlash = true;

  haskellPackageOverrides = self: super: with pkgs.haskell.lib; {
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

    my-vim = vimUtils.makeCustomizable (callPackage <nixpkgs/pkgs/applications/editors/vim/configurable.nix> {
      inherit (darwin.apple_sdk.frameworks) CoreServices Cocoa Foundation CoreData;
      inherit (darwin) libobjc cf-private;
      features = "huge";
      lua = lua5_1;
      gui = config.vim.gui or "auto";
      flags = [ "python" "X11" ];
      python = python.buildEnv.override {
        extraLibs = [ pythonPackages.pycrypto ];
      };
    });

  };

}
