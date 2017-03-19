{ pkgs, lib, ... }: {

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  boot.kernel.sysctl = {
    "kernel.yama.ptrace_scope" = lib.mkDefault "0";
  };

  time.timeZone = "America/Chicago";

  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
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
    lockOn.suspend = true;
    lockOn.hibernate = true;
  };

}
