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
      displayManager.sessionCommands = ''
        xrdb -merge ${./xresources}
      '';
    };

    environment.systemPackages = with pkgs; with gnomeExtensions; [
      (callPackage ./xstuff {})

      glib.dev
      gnome3.gsettings_desktop_schemas
      ffmpegthumbnailer

      dash-to-dock
      dash-to-panel

      # gptfdisk

      # moka-icon-theme
      # arc-theme
      # theme-vertex
    ];

  };

}
