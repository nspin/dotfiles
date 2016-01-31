{ config, pkgs, ... }:

{
  nixpkgs.config = import ../../pkgs/config.nix;

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

  security.sudo.wheelNeedsPassword = false;

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
}
