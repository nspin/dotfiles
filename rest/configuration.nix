# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixos"; # Define your hostname.
  networking.hostId = "c890f48c";
  # networking.wireless.enable = true;  # Enables wireless.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git
    tmux
    screen
    vim
    wget
    firefox
    links
    haskellPackages.Elm
    haskellPackages.elmReactor
    haskellPackages.elmGet
    haskellPackages.elmRepl
    slimThemes.nixosSlim
    # xlibs.xauth
    # xlibs.xinit
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.autorun = false;
  services.xserver.enable = true;
  # services.xserver.layout = "us";

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

  # services.xserver.displayManager.sessionCommands = "xset r rate 300 50";
  # services.xserver.windowManager.xmonad.enable = true;
  # services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  # services.xserver.windowManager.default = "xmonad";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.nick = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

}
