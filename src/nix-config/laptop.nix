{ config, pkgs, ... }:

{
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  # ___
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixos";
  networking.hostId = "c890f48c";
  # networking.wireless.enable = true;

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

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

  services.xfs.enable = true;

  services.xserver = {

    autorun = true;
    enable = true;
    layout = "us";

    windowManager.xmonad.enable = true;
    windowManager.xmonad.extraPackages = haskellPackages: [
      haskellPackages.xmonad-contrib
      haskellPackages.xmonad-extras
    ];

    displayManager.sessionCommands = "bash /home/nick/dotfiles/src/x11/pre-wm.sh";

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

  # misc command line utils
    zip
    unzip
    tree

  # x utils
    xfontsel
    xlsfonts
    xclip
    xlibs.xmodmap
    xlibs.xmessage
    dmenu
    gmrun
    haskell.packages.ghc7102.xmobar

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
    haskell.packages.ghcjs.ghc

  # java bullshit
    jdk
    maven

  # other languages
    gcc
    racket
    nodejs

  # failing for unknown reasons

    # haskellPackages.ghc-mod
    # haskellPackages.Agda

    # haskellPackages.elm-make
    # haskellPackages.elm-reactor
    # haskellPackages.elm-package
    # haskellPackages.elm-repl
  ];
}