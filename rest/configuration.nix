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

  # It appears that elmRepl doesn't include a dependency on nodejs. TODO add it
  environment.systemPackages = with pkgs; [

    manpages

    tmux
    screen
    vimHugeX
    git
    xclip

    wget
    links
    firefox

    gcc
    nodejs

    haskellPackages.Elm
    haskellPackages.elmReactor
    haskellPackages.elmGet
    haskellPackages.elmRepl
    haskellPackages.elmServer

    haskellPackages.xmonad
    haskellPackages.xmonadContrib
  ];

  services.openssh.enable = true;

  # services.printing.enable = true;

  services.xserver.autorun = true;
  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.displayManager.session =
    [ { manage = "window";
        name = "xmonad";
        start = ''
            xset r rate 300 50
            ${pkgs.haskellPackages.xmonad}/bin/xmonad &
        '';
      }
      { manage = "desktop";
        name = "xterm";
        start = ''
            ${pkgs.xterm}/bin/xterm -ls &
        '';
      }
    ];

  services.xserver.displayManager.slim.enable = true;
  # services.xserver.displayManager.slim.theme = pkgs.slimThemes.nixosSlim;
  services.xserver.displayManager.slim.theme = pkgs.fetchurl {
      url = "https://github.com/jagajaga/nixos-slim-theme/archive/Final.tar.gz";
      sha256 = "4cab5987a7f1ad3cc463780d9f1ee3fbf43603105e6a6e538e4c2147bde3ee6b";
    };

  users.extraUsers.nick = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

}
