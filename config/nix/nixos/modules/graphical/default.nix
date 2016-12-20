{pkgs, lib, config, ...}:

with lib;
let
  inherit (lib) mkOption mkIf;
  cfg = config.my.graphical;
in
{

  imports = [
    ./my-xmonad.nix
  ];

  options = {
    my.graphical = {
      isLaptop = mkOption {
        default = false;
        example = true;
        type = lib.types.bool;
        description = "Should status include wifi and battery?";
      };
    };
  };

  config = {

    fonts = {
      enableFontDir = true;
      fontconfig.enable = true;
      fonts = [
        pkgs.dejavu_fonts
        pkgs.font-awesome-ttf
      ];
    };

    services.xserver = {

      enable = true;
      autorun = true;
      layout = "us";

      displayManager.slim.enable = true;
      displayManager.slim.theme = ./slim-theme;

      displayManager.sessionCommands = ''
          xrdb -merge ${./xresources}
          xmodmap ${./Xmodmap}
          xset r rate 300 50
          xsetroot -cursor_name left_ptr&
          if [ -x "~/.fehbg" ]; then
            ~/.fehbg
          else
            pape=""
            for img in ~/.wallpaper.{png,jpg}; do
                if [ -f "$img" ]; then
                    pape="$img"
                fi
            done
            if [ -n "$pape" ]; then
                feh --no-fehbg --bg-max "$pape"
            else
              xsetroot -solid '#000000'
            fi
          fi
      '';

      windowManager.my-xmonad.enable = true;
      windowManager.my-xmonad.isLaptop = cfg.isLaptop;

      desktopManager.xterm.enable = false;

      # desktopManager.kde4.enable = true;
      # displayManager.kdm.enable = true;

    };

  };

}
