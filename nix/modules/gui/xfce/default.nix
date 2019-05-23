{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.my.gui.xfce;

in {

  options = {

    my.gui.xfce.enable = mkEnableOption "xfce";

  };

  config = mkIf cfg.enable {

    networking.networkmanager.enable = true;
    users.extraGroups.networkmanager.members = [ "nick" "other" ];

    services.xserver = {
      displayManager.sddm.enable = true;
      displayManager.sddm.theme = "abstractdark";
      displayManager.sessionCommands = ''
        xrdb -merge ${./xresources}
        xmodmap ${./Xmodmap}
      '';
        # xset r rate 200 50
      # displayManager.setupCommands = ''
      #   xrdb -merge ${./xresources}
      #   xmodmap ${./Xmodmap}
      #   xset r rate 200 50
      # '';
      desktopManager.xterm.enable = false;
      desktopManager.xfce.enable = true;
      # desktopManager.xfce.thunarPlugins = [
      #   pkgs.xfce.thunar-archive-plugin
      # ];
      # autoRepeatDelay = 200;
      # autoRepeatInterval = 20;
    };

    environment.pathsToLink = [
      "/libexec/thunar-archive-plugin"
    ];

    environment.systemPackages = with pkgs; with pkgs.xfce; [
      (callPackage ./xstuff.nix {})

      # chicago95-theme
      sddm-theme-abstractdark
      # xfce.tumbler
      # ffmpegthumbnailer
      gstreamer

      # moka-icon-theme
      # arc-theme
      # theme-vertex
      # sierra-gtk-theme

      pmtools
      pmutils
      jmtpfs
      usbutils
      sysstat

      # xfce4-battery-plugin
      # xfce4-clipman-plugin
      # xfce4-cpufreq-plugin
      # xfce4-cpugraph-plugin
      # xfce4-datetime-plugin
      # xfce4-embed-plugin
      # xfce4-eyes-plugin
      # xfce4-fsguard-plugin
      # xfce4-genmon-plugin
      # xfce4-hardware-monitor-plugin
      # xfce4-netload-plugin
      # xfce4-mpc-plugin
      # xfce4-sensors-plugin
      # xfce4-systemload-plugin
      # xfce4-verve-plugin
      # xfce4-whiskermenu-plugin
      # xfce4-windowck-plugin
      # xfce4-pulseaudio-plugin

      wirelesstools
      iw
    ];

  };

}
