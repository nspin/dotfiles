{ pkgs, ... }: {

  imports = [ ./common.nix ];

  # systemd.services."my-pre-suspend" = {
  #   description = "Pre-Suspend Actions";
  #   wantedBy = [ "suspend.target" ];
  #   before = [ "systemd-suspend.service" ];
  #   script = ''
  #     ${pkgs.xscreensaver}/bin/xscreensaver-command -lock
  #   '';
  #   serviceConfig.Type = "simple";
  # };

  services.xserver = {

    desktopManager.xterm.enable = false;
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;

    displayManager.slim.enable = true;
    displayManager.slim.theme = ./slim-theme;
    displayManager.slim.extraConfig = ''
      sessionstart_cmd ${pkgs.xorg.sessreg}/bin/sessreg -a -l tty$(${pkgs.kbd}/bin/fgconsole) %user
      sessionstop_cmd  ${pkgs.xorg.sessreg}/bin/sessreg -d -l tty$(${pkgs.kbd}/bin/fgconsole) %user
    '';

    displayManager.sessionCommands = ''
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
        # ${pkgs.trayer}/bin/trayer --monitor primary --align right --height 25 --widthtype request --transparent true --tint 0x073642 &
        # ${pkgs.networkmanagerapplet}/bin/nm-applet &
        # ${pkgs.pnmixer}/bin/pnmixer &
        # ${pkgs.pasystray}/bin/pasystray &
    '';

  };

}
