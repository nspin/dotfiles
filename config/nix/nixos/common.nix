{ pkgs, ... }:

{
  imports = [ ./modules/wmdev.nix ];

  nixpkgs.config = import <dotfig/nix/config.nix>;

  networking.hostName = "nixos";
  networking.hostId = "c890f48c";

  time.timeZone = "America/Chicago";

  users.extraUsers.nick = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  security.sudo = {
    wheelNeedsPassword = false;
    extraConfig = ''
      Defaults env_keep += "NIX_PATH"
    '';
  };

  fonts = {
    enableFontDir = true;
    fontconfig.enable = true;
    fonts = [
      pkgs.dejavu_fonts
    ];
  };

  # services.printing.enable = true;

  services.openssh.enable = true;

  # services.xfs.enable = true;


  services.xserver = {

    autorun = true;
    enable = true;
    layout = "us";

    windowManager.wmdev = {
      enable = true;
      command = "/home/nick/bin/wm";
    };

    # windowManager.xmonad.enable = true;
    # windowManager.xmonad.extraPackages = haskellPackages: [
    #   (haskellPackages.callPackage <dotfig/xmonad> {})
    # ];

    displayManager = {
      sessionCommands = builtins.readFile <dotfig/x11/prewm.sh>;
      slim.enable = true;
      slim.defaultUser = "nick";
      slim.theme = pkgs.fetchurl {
          url = "https://github.com/jagajaga/nixos-slim-theme/archive/Final.tar.gz";
          sha256 = "4cab5987a7f1ad3cc463780d9f1ee3fbf43603105e6a6e538e4c2147bde3ee6b";
      };
    };

    desktopManager.xterm.enable = false;

  };
}
