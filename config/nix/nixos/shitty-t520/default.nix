{ pkgs, ... }: {

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  time.timeZone = "America/Chicago";

  # services.xserver.windowManager.my-xmonad.enable = true;
  # services.xserver.windowManager.my-xmonad.isLaptop = true;

  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.extraPackages = hp: [
    ((hp.callPackage <dotfig/xmonad> {}) {
      isLaptop = true;
      isExecutable = false;
    })
  ];

  services.xserver.desktopManager.xterm.enable = false;

  # desktopManager.kde4.enable = true;
  # displayManager.kdm.enable = true;

  system.stateVersion = "16.03";

  imports = [
    ./net.nix
    ./media.nix
    ./hardware.nix
    ./pkgs.nix
    ./gpkgs.nix
    ../common/config.nix
    ../common/x
    ../common/my-xmonad.nix
  ];

  users.extraUsers = {
    nick = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" ];
    };
    guest = {
      isNormalUser = true;
      uid = 1001;
    };
    other = {
      isNormalUser = true;
      uid = 1002;
      extraGroups = [ "wheel" ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  services.physlock = {
    enable = true;
    # user = "nick";
    lockOn.suspend = true;
    lockOn.hibernate = true;
  };

}
