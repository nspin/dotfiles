{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.my.gui.gnome;

in {

  options = {

    my.gui.gnome.enable = mkEnableOption "gnome";

  };

  config = mkIf cfg.enable {

    services.xserver = {
      desktopManager.gnome3.enable = true;
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = false; # so can use xmodmap instead of xkb
      displayManager.gdm.autoLogin.user = "x";
      displayManager.sessionCommands = ''
        xrdb -merge ${./xresources}
      '';
      # displayManager.setupCommands = ''
      #   xset r rate 200 50
      #   xmodmap ${./Xmodmap}
      #   xrdb -merge ${./xresources}
      # '';
      # autoRepeatDelay = 200;
      # autoRepeatInterval = 20;
    };

    environment.systemPackages = with pkgs; with gnomeExtensions; [
      (callPackage ./xstuff.nix {})

      glib.dev
      gnome3.gsettings_desktop_schemas
      ffmpegthumbnailer

      dash-to-dock
      dash-to-panel

      sierra-gtk-theme
    ];

  };

}
