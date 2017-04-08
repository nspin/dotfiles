{ pkgs }: {

  allowUnfree = true;
  allowBroken = true;
  permittedInsecurePackages = [ "webkitgtk-2.4.11" ];

  pulseaudio = true;
  firefox.enableAdobeFlash = true;
  chromium.enablePepperFlash = true;

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

    readme-preview = callPackage ./local/grip {};
    chicago95-theme = callPackage ./local/chicago95-theme {};

    uttyl = callPackage <dotfiles/../uttyl> {};
    fznode = callPackage <dotfiles/../fznode> {};

    my-vim = callPackage <nixpkgs/pkgs/applications/editors/vim/configurable.nix> {
      inherit (darwin.apple_sdk.frameworks) CoreServices Cocoa Foundation CoreData;
      inherit (darwin) libobjc cf-private;
      features = "huge";
      gui = "auto";
      lua = lua5_1;
      flags = [ "python" ];
      python = python.buildEnv.override {
        extraLibs = [ pythonPackages.pycrypto ];
      };
    };

    # patched

    # meson_39_1 = callPackage ./local/meson {};

    mitmproxy = callPackage ./local/mitmproxy {};
    spotify-ripper = callPackage ./local/spotify-ripper {};
    apktool = callPackage ./local/apktool {
      buildTools = androidenv.buildTools;
    };

    lightdm_webkit2_greeter = callPackage ./local/lightdm-webkit2-greeter {};

    # lxqt = recurseIntoAttrs (import ./local/lxqt {
    #   inherit pkgs libsForQt5 fetchFromGitHub;
    #   inherit (lib) makeScope;
    # });

    # lightdm_1_18_2 = libsForQt5.callPackage ./local/lightdm/lightdm_1_18_2.nix {
    #   qt4 = null;
    #   withQt5 = false;
    # };

    # webkit2gtk = callPackage <nixpkgs/pkgs/development/libraries/webkitgtk/2.4.nix> {
    #   # withGtk2 = false;
    #   harfbuzz = harfbuzz-icu;
    #   gst-plugins-base = gst_all_1.gst-plugins-base;
    #   inherit (darwin) libobjc;
    # };

    # lightdm_webkit_greeter = callPackage ./local/lightdm/webkit_greeter.nix {
    #   lightdm = lightdm_1_18_2;
    # };

  };

}
