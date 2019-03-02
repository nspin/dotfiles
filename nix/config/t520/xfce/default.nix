{ pkgs, config, lib, ... }: {

  imports = [
    ./pkgs.nix
    ./hardware.nix
  ];

  environment.systemPackages = with pkgs; [
    chicago95-theme
    sddm-theme-abstractdark
    xfce.tumbler
    ffmpegthumbnailer
    gstreamer
    gnome3.file-roller
    # xarchiver
    # kdeApplications.ark
    # lightdm-web-greeter
  ];

  services.xserver = {

    displayManager.sddm.enable = true;
    displayManager.sddm.theme = "abstractdark";

    displayManager.sessionCommands = ''
      xrdb -merge ${./xresources}
      xmodmap ${./Xmodmap}
    '';

    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;
    desktopManager.xfce.thunarPlugins = [
      pkgs.xfce.thunar-archive-plugin
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

  };

  # boot.plymouth.enable = true;
  # boot.plymouth.theme = "Chicago95";
  # boot.plymouth.themePackages = [
  #   pkgs.chicago95-theme
  # ];

  environment.pathsToLink = [
    "/libexec/thunar-archive-plugin"
  ];

}
