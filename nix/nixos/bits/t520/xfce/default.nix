{ pkgs, config, lib, ... }: {

  imports = [
    ./pkgs.nix
    ./hardware.nix
    # ./wkg.nix
  ];

  boot.plymouth.enable = true;
  boot.plymouth.theme = "Chicago95";
  boot.plymouth.themePackages = [
    pkgs.chicago95-theme
  ];

  environment.systemPackages = [
    pkgs.chicago95-theme
  ];

  services.xserver = {
    # synaptics.enable = false;

    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;
    # desktopManager.gnome3.enable = true;

    displayManager.lightdm.enable = true;
    # displayManager.lightdm.greeters.gtk.enable = false;

    # displayManager.sddm.enable = true;
    # displayManager.sddm.theme = "absdark";
    # displayManager.sddm.package = pkgs.sddm.override {
    #   themes = [ (pkgs.callPackages ./sddm-themes/absdark.nix {}) ];
    # };

    displayManager.sessionCommands = ''
      xrdb -merge ${./xresources}
      xmodmap ${./Xmodmap}
      xset r rate 200 50 # TODO (doesn't have effect)
    '';

  };

}
