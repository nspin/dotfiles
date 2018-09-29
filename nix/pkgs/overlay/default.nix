self: super: with self; {

  vim-plugins = callPackage ./vim-plugins {};
  dotfiles = callPackage ./dotfiles {};

  my-vim = callPackage ./pkgs/my-vim {
    inherit (darwin.apple_sdk.frameworks) CoreServices Cocoa Foundation CoreData;
    inherit (darwin) libobjc cf-private;
  };

  my-vim-gui = callPackage ./pkgs/my-vim {
    inherit (darwin.apple_sdk.frameworks) CoreServices Cocoa Foundation CoreData;
    inherit (darwin) libobjc cf-private;
    gui = "auto";
  };

  readme-preview = callPackage ./pkgs/grip {};
  uttyl = callPackage ./pkgs/uttyl {};
  fznode = callPackage ./pkgs/fznode {};
  gcc-aarch64-elf = callPackage ./pkgs/gcc-aarch64-elf {};

  ncslib = callPackage ./lib {};
  ghc-pkg-db = callPackage ./plib/ghc-pkg-db {};

  binutils-all = callPackage ./patched/binutils-all {
    noSysDirs = true;
    targetPlatform = platforms.aarch64-multiplatform;
  };

  # patched

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

  # rEnv = super.rWrapper.override {
  #   packages = import ./misc/cmc-r-installed.nix self.rPackages;
  # };

  # rstudioEnv = super.rstudio.override {
  #   R = rEnv;
  #   useRPackages = true;
  # };
}
