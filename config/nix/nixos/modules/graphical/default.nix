{ pkgs, ... }:

{

  fonts = {
    enableFontDir = true;
    fontconfig.enable = true;
    fonts = [
      pkgs.dejavu_fonts
    ];
  };

  services.xserver = {

    enable = true;
    autorun = true;
    layout = "us";

    displayManager.slim = {
      enable = true;
      # defaultUser = "nick";
      theme = ./slim-theme;
    };

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

    windowManager = {
      session = [{
        name = "xmonad";
        start =
          let
            my-xmonad = pkgs.haskellPackages.callPackage <dotfig/xmonad> {};
          in ''
            # logdir=/var/log/wmdev
            # mkdir -p $logdir
            # ${my-xmonad}/bin/xmonad > $logdir/out.log 2> $logdir/err.log &
            ${my-xmonad}/bin/xmonad
            waitPID=$!
          '';
      }];
    };

    desktopManager.xterm.enable = false;

    # desktopManager.kde4.enable = true;
    # displayManager.kdm.enable = true;

  };

}
