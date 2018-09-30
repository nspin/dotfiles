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
    pkgs.lightdm-web-greeter
    (pkgs.callPackages ./sddm-themes/absdark.nix {})
  ];

  services.xserver = {
    # synaptics.enable = false;

    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;

    # displayManager.lightdm.enable = true;
    # displayManager.lightdm.greeters.gtk.enable = false;
    # displayManager.lightdm.greeters.web.enable = true;
    # displayManager.lightdm.greeters.web.theme.name = "default";
    # displayManager.lightdm.greeters.web.theme.package = pkgs.lightdm-web-greeter.theme;
    # displayManager.lightdm.greeters.web.theme.name = "Chicago95";
    # displayManager.lightdm.greeters.web.theme.package = pkgs.chicago95-theme;
    # displayManager.lightdm.greeters.web.theme.name = "test";
    # displayManager.lightdm.greeters.web.theme.package = pkgs.stdenv.mkDerivation {
    #   name = "foo";
    #   builder = builtins.toFile "builder.sh" ''
    #     . $stdenv/setup
    #     cp -r ${/home/nick/scratch/x} $out
    #   '';
    # };

    displayManager.sddm.enable = true;
    displayManager.sddm.theme = "absdark";
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
