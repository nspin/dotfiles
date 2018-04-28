{ pkgs }: {

  allowUnfree = true;
  allowBroken = true;

  # pulseaudio = true;
  # firefox.enableAdobeFlash = true;
  # chromium.enablePepperFlash = true;

  packageOverrides = super: let self = super.pkgs; in with self; {

    darwin-env = buildEnv {
      name = "darwin-env";
      paths = import ./darwin-env.nix self ++ (
        let local = <local/darwin-env.nix>;
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
    };

    my-vim-no-gui = callPackage <nixpkgs/pkgs/applications/editors/vim/configurable.nix> {
      inherit (darwin.apple_sdk.frameworks) CoreServices Cocoa Foundation CoreData;
      inherit (darwin) libobjc cf-private;
      features = "huge";
      gui = "no";
      lua = lua5_1;
      flags = [ "python" ];
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
    gcc-aarch64-elf = callPackage ./pkgs/gcc-aarch64-elf {};

    ncslib = callPackage ./lib {};
    ghc-pkg-db = callPackage ./plib/ghc-pkg-db {};

    qemuRpi3 = lib.overrideDerivation qemu (self: {
      patches = [
        <nixpkgs/pkgs/applications/virtualization/qemu/no-etc-install.patch>
        <nixpkgs/pkgs/applications/virtualization/qemu/statfs-flags.patch>
        ./patched/qemu-rpi3.patch
        <nixpkgs/pkgs/applications/virtualization/qemu/fix-hda-recording.patch>
      ];
    });

    qemuSmall = lib.overrideDerivation
      (callPackage <nixpkgs/pkgs/applications/virtualization/qemu> {
        numaSupport = false;
        seccompSupport = false;
        pulseSupport = false;
        sdlSupport = false;
        vncSupport = false;
        spiceSupport = false;
        usbredirSupport = false;
        inherit (darwin.apple_sdk.frameworks) CoreServices Cocoa;
        inherit (darwin.stubs) rez setfile;
      })
      (self: {
        patches = [
          <nixpkgs/pkgs/applications/virtualization/qemu/no-etc-install.patch>
          <nixpkgs/pkgs/applications/virtualization/qemu/statfs-flags.patch>
          ./patched/qemu-rpi3.patch
        ];
      });

    # rEnv = super.rWrapper.override {
    #   packages = import ./cmc-r-installed.nix self.rPackages;
    # };

    # rstudioEnv = super.rstudio.override {
    #   R = rEnv;
    #   useRPackages = true;
    # };

    # patched

    binutils-all = callPackage ./patched/binutils-all {
      noSysDirs = true;
      targetPlatform = platforms.aarch64-multiplatform;
    };

    # apktool = callPackage ./patched/apktool {
    #   buildTools = androidenv.buildTools;
    # };

  };

}
