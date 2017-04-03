{ pkgs, lib, ... }: {

  imports = [
    ./pkgs.nix
    ./hardware.nix
    ./wkg.nix
  ];

  boot.plymouth.enable = true;

  services.xserver = {

    desktopManager.xfce.enable = true;

    displayManager.lightdm.enable = true;

    displayManager.lightdm.greeters.gtk.enable = true;

    # displayManager.sddm.enable = true;
    # displayManager.sddm.theme = "absdark";
    # displayManager.sddm.package = pkgs.sddm.override {
    #   themes = [ (pkgs.callPackages ../mouse/sddm-themes/absdark.nix {}) ];
    # };

    displayManager.sessionCommands = ''
      xrdb -merge ${./xresources}
      xmodmap ${./Xmodmap}
    '';

  };

}
