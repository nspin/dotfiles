{ pkgs }: {

  allowUnfree = true;
  allowBroken = true;
  permittedInsecurePackages = [ "webkitgtk-2.4.11" ];

  pulseaudio = true;
  firefox.enableAdobeFlash = true;
  chromium.enablePepperFlash = true;

  packageOverrides = super: let self = super.pkgs; in with self; {

    darwin-env = buildEnv {
      name = "darwin-env";
      paths = import ./darwin-env.nix self ++ (
        let local = <local> + "darwin-env.nix";
        in if lib.pathExists local then import local self else []
      );
    };

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

    ihaskell = callPackage <nixpkgs/pkgs/development/tools/haskell/ihaskell/wrapper.nix> {
      inherit (haskellPackages) ghcWithPackages;
      jupyter = python3.withPackages (ps: with ps; [
        notebook
        jupyter_console
        nbconvert
        ipykernel
        ipywidgets
      ]);
      packages = self: with self; [ pandoc ];
    };

    readme-preview = callPackage ./pkgs/grip {};
    uttyl = callPackage ./pkgs/uttyl {};
    fznode = callPackage ./pkgs/fznode {};

    ncslib = callPackage ./lib {};
    ghc-pkg-db = callPackage ./plib/ghc-pkg-db {};

    # rEnv = super.rWrapper.override {
    #   packages = import ./cmc-r-installed.nix self.rPackages;
    # };

    # rstudioEnv = super.rstudio.override {
    #   R = rEnv;
    #   useRPackages = true;
    # };

    binutils-all = callPackage ./patched/binutils-all {
      noSysDirs = true;
      targetPlatform = platforms.aarch64-multiplatform;
    };

    # patched

    lightdm_webkit2_greeter = callPackage ./patched/lightdm-webkit2-greeter {};

    # spotify-ripper = callPackage ./patched/spotify-ripper {};

    # apktool = callPackage ./patched/apktool {
    #   buildTools = androidenv.buildTools;
    # };

  };

}
