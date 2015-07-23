{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

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

  # TODO what about runtime dependencies (e.g. elm-repl and nodejs)?
  environment.systemPackages = with pkgs; [

    xclip

    tmux
    vimHugeX
    git

    wget
    firefox

    gcc
    nodejs

    haskell.packages.ghc784.elm-make

    # haskellPackages.aeson
    # haskellPackages.wget
    # haskellPackages.lens
    # haskellPackages.attoparsec

    # haskellPackages.elm-package
    # haskellPackages.elm-reactor
    # haskellPackages.elm-repl
    # haskellPackages.elm-server
  ];

  services.openssh.enable = true;

  # services.printing.enable = true;

  services.xserver.autorun = true;
  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;

  services.xserver.displayManager.sessionCommands ="xset r rate 300 50";

  services.xserver.displayManager.slim.enable = true;
  services.xserver.displayManager.slim.defaultUser = "nick";
  # services.xserver.displayManager.slim.theme = pkgs.slimThemes.nixosSlim;
  services.xserver.displayManager.slim.theme = pkgs.fetchurl {
      url = "https://github.com/jagajaga/nixos-slim-theme/archive/Final.tar.gz";
      sha256 = "4cab5987a7f1ad3cc463780d9f1ee3fbf43603105e6a6e538e4c2147bde3ee6b";
  };

  services.xserver.desktopManager.xterm.enable = true;

  users.extraUsers.nick = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

}
