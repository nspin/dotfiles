{ pkgs, ... }: {

  imports = [ ./common.nix ];

  services.xserver = {

    # desktopManager.lxqt.enable = true;

    desktopManager.default = "none";
    windowManager.default = "openbox";
    windowManager.openbox.enable = true;

    displayManager.sessionCommands = ''
        ${pkgs.xscreensaver}/bin/xscreensaver -nosplash &
        if [ -x ~/.screenlayout/go.sh ]; then
          ~/.screenlayout/go.sh
        fi
        xrdb -merge ${./xresources}
        xmodmap ${./Xmodmap}
        xset r rate 300 50
        xsetroot -cursor_name left_ptr&
        if [ -x ~/.fehbg ]; then
          ~/.fehbg
        else
          pape=""
          for img in ~/.wallpaper.{png,jpg}; do
            if [ -f "$img" ]; then
                pape="$img"
            fi
          done
          if [ -n "$pape" ]; then
            ${pkgs.feh}/bin/feh --no-fehbg --bg-max "$pape"
          else
            xsetroot -solid '#000000'
          fi
        fi
        ${pkgs.trayer}/bin/trayer --monitor primary --align right --height 25 --widthtype request --transparent true --tint 0x073642 &
        ${pkgs.networkmanagerapplet}/bin/nm-applet &
        ${pkgs.pnmixer}/bin/pnmixer &
        ${pkgs.pasystray}/bin/pasystray &
    '';

  };

}
