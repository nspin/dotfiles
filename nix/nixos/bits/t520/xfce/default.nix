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

  environment.systemPackages = with pkgs; [
    chicago95-theme
    lightdm-web-greeter
    (callPackages ./sddm-themes/absdark.nix {})
    xarchiver
    # tumbler
    ffmpegthumbnailer
    gstreamer
    kdeApplications.ark
    gnome3.file-roller
  ];

  environment.pathsToLink = [
    "/libexec/thunar-archive-plugin"
  ];

  services.xserver = {
    # synaptics.enable = false;

    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;
    desktopManager.xfce.thunarPlugins = [
      pkgs.xfce.thunar-archive-plugin
      pkgs.xfce.thunar-dropbox-plugin
    ];

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
    '';

  };

}
