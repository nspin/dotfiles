{ pkgs, config, lib, ... }: {

  imports = [
    ./pkgs.nix
    ./hardware.nix
    # ./wkg.nix
  ];

  # boot.plymouth.enable = true;

  services.xserver = {
    # synaptics.enable = false;

    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;
    # desktopManager.gnome3.enable = true;

    # displayManager.lightdm.enable = true;
    # displayManager.lightdm.greeters.gtk.enable = false;

    displayManager.sddm.enable = true;
    displayManager.sddm.theme = "absdark";
    displayManager.sddm.package = pkgs.sddm.override {
      themes = [ (pkgs.callPackages ../mouse/sddm-themes/absdark.nix {}) ];
    };

    displayManager.sessionCommands = ''
      xrdb -merge ${./xresources}
      xmodmap ${./Xmodmap}
    '';

  };

}
