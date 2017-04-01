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

    uttyl = callPackage <dotfiles/../uttyl> {};
    fznode = callPackage <dotfiles/../fznode> {};

    lxqt = recurseIntoAttrs (import ./local/lxqt {
      inherit pkgs libsForQt5 fetchFromGitHub;
      inherit (lib) makeScope;
    });

    chicago95-theme = callPackage ./local/chicago95-theme {};

    my-vim = callPackage <nixpkgs/pkgs/applications/editors/vim/configurable.nix> {
      inherit (darwin.apple_sdk.frameworks) CoreServices Cocoa Foundation CoreData;
      inherit (darwin) libobjc cf-private;
      features = "huge";
      gui = "no";
      lua = lua5_1;
      flags = [ "python" ];
      python = python.buildEnv.override {
        extraLibs = [ pythonPackages.pycrypto ];
      };
    };

  };

}
