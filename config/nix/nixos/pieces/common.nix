{ pkgs, ... }:

{
  nixpkgs.config = import <dotfig/nix/config.nix>;

  networking.hostName = "nixos";
  networking.hostId = "c890f48c";

  time.timeZone = "America/Chicago";

  users.extraUsers.nick = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  security.sudo.wheelNeedsPassword = false;

  security.sudo.extraConfig = ''
    Defaults env_keep += "NIX_PATH"
  '';

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
      (haskellPackages.callPackage <dotfig/xmonad> {})
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
