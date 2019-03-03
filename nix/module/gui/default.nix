{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.my.gui;

in {

  imports = [
    ./xmonad
    ./gnome
  ];

  options = {

    my.gui.enable = mkEnableOption "gui";

  };

  config = mkIf cfg.enable {

    services.xserver = {
      enable = true;
      autorun = true;
      layout = "us";
    };
    
    fonts = {
      enableFontDir = true;
      fontconfig.enable = true;
      fonts = [
        pkgs.dejavu_fonts
      ];
    };

  };

}
