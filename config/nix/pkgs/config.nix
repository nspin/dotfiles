{ pkgs }: {

  allowUnfree = true;
  allowBroken = true;

  firefox.enableAdobeFlash = true;

  haskellPackageOverrides = self: super: with pkgs.haskell.lib; {
    hakyll = dontCheck (self.callPackage ./local/hackage-packages/hakyll.nix {});
    http-client-tls_0_3_3 = super.http-client-tls_0_3_3.override { http-client = self.http-client_0_5_3_3; };
  };

  packageOverrides = super: let self = super.pkgs; in with self; {

    darwin-env = buildEnv {
      name = "darwin-env";
      paths = import ./darwin-env.nix self;
    };

    my-lib = callPackage ./lib {};
    ghc-pkg-db = callPackage ./aux/ghc-pkg-db {};

    # spotify-ripper = callPackage ./local/spotify-ripper {};
    # apktool = callPackage ./local/apktool {
    #   buildTools = androidenv.buildTools;
    # };

    mitmproxy = callPackage ./local/mitmproxy {};
    readme-preview = callPackage ./local/grip {};

    uttyl = callPackage <dotfig/../../uttyl> {};
    fznode = callPackage <dotfig/../../fznode> {};

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
