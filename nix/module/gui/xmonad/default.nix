{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.my.gui.xmonad;

in {

  options = {

    my.gui.xmonad.enable = mkEnableOption "xmonad";

    my.gui.xmonad.background = mkOption {
      default = null;
    };

  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      haskellPackages.xmobar
      scrot
    ];

    services.xserver = {

      displayManager.auto.enable = true;
      displayManager.auto.user = "x";
      displayManager.sessionCommands = ''
        xrdb -merge ${./xresources}
        xmodmap ${./Xmodmap}
        xset r rate 300 50
        xsetroot -cursor_name left_ptr
      '' + optionalString (cfg.background != null) ''
        ${pkgs.feh}/bin/feh --no-fehbg --bg-max ${cfg.background}
      '';

      windowManager.default = "xmonad";
      windowManager.xmonad.enable = true;
      windowManager.xmonad.extraPackages = hp: with hp; [
        xmonad-contrib
      ];

      desktopManager.default = "mine";
      desktopManager.xterm.enable = false;
      desktopManager.session = singleton {
        name = "mine";
        bgSupport = true;
        start = "";
      };

    };

  };

}
