{ pkgs, ... }: {

  imports = [ ./common.nix ];

  services.xserver = {
    desktopManager.xterm.enable = false;
    desktopManager.lxqt.enable = true;
    displayManager.sddm.enable = true;
  };

}
