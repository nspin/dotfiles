{ config, pkgs, ... }:

{
  nixpkgs.config = import ./config.nix;

  boot.loader.grub.device = "/dev/sda";
  # boot.loader.grub.enable = true;
  # boot.loader.grub.version = 2;

  networking.hostName = "nixos";
  networking.hostId = "c890f48c";
  # networking.wireless.enable = true;

  time.timeZone = "America/Chicago";

  users.extraUsers.nick = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  fonts.enableFontDir = true;
  fonts.fontconfig.enable = true;
  fonts.fonts = [
    pkgs.dejavu_fonts
  ];

  # services.printing.enable = true;

  services.openssh.enable = true;

  # services.xfs.enable = true;

  services.xserver = {

    autorun = true;
    enable = true;
    layout = "us";

    windowManager.xmonad.enable = true;
    windowManager.xmonad.extraPackages = haskellPackages: [
      haskellPackages.xmonad-contrib
      haskellPackages.xmonad-extras
    ];

    displayManager.slim.enable = true;
    displayManager.slim.defaultUser = "nick";
    # displayManager.slim.theme = pkgs.slimThemes.nixosSlim;
    displayManager.slim.theme = pkgs.fetchurl {
        url = "https://github.com/jagajaga/nixos-slim-theme/archive/Final.tar.gz";
        sha256 = "4cab5987a7f1ad3cc463780d9f1ee3fbf43603105e6a6e538e4c2147bde3ee6b";
    };

    desktopManager.xterm.enable = false;
  };

  environment.systemPackages = with pkgs; [

    (texLiveAggregationFun { paths = [ texLive texLiveExtra texLiveBeamer lmodern ]; })

  # nix
    nix-repl
    nix-prefetch-scripts

  # random
    rlwrap

  # misc command line utils
    zip
    unzip
    tree
    fzf

  # x tools
    xfontsel
    xclip
    xorg.xlsfonts
    xorg.xkill
    xlibs.xmodmap
    xlibs.xev
    xbrightness
    arandr
    xlibs.xgamma
    xlibs.xbacklight

  # x utils
    dmenu
    gmrun
    xlibs.xmessage
    haskell.packages.ghc7102.xmobar

  # fonts
    dejavu_fonts

  # x applications
    firefox
    xchat

  # general development
    tmux
    vimHugeX
    git

  # ghc
    haskell.packages.ghc7102.ghc
    haskell.packages.ghc7102.cabal-install
    haskell.packages.ghc7102.cabal2nix
    haskell.packages.ghc7102.hoogle
    haskell.packages.ghc7102.hdevtools
    haskell.packages.ghc7102.hlint

  # ghcjs
    # haskell.packages.ghcjs.ghc

  # java bullshit
    jdk
    maven

  # other languages
    gcc
    clang
    # mitscheme
    # racket
    nodejs
    python27

  # other
    haskell.packages.ghc7102.pandoc
    # haskell.packages.ghc7102.hakyll

  # failing for unknown reasons

    # haskellPackages.ghc-mod
    # haskellPackages.Agda

    # haskellPackages.elm-make
    # haskellPackages.elm-reactor
    # haskellPackages.elm-package
    # haskellPackages.elm-repl
  ];
}
