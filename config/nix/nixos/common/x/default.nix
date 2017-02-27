{ pkgs, ... }: {

  fonts = {
    enableFontDir = true;
    fontconfig.enable = true;
    fonts = [
      pkgs.dejavu_fonts
      pkgs.font-awesome-ttf
    ];
  };

  environment.systemPackages = with pkgs; [
    xclip
    xorg.xkill
    xorg.xwininfo
    xlibs.xmodmap
    xlibs.xmessage
    xlibs.xev
    dejavu_fonts
  ];

  services.xserver = {

    enable = true;
    autorun = true;
    layout = "us";

    displayManager.slim.enable = true;
    displayManager.slim.theme = ./slim-theme;
    displayManager.slim.extraConfig = ''
      sessionstart_cmd ${pkgs.xorg.sessreg}/bin/sessreg -a -l tty$(${pkgs.kbd}/bin/fgconsole) %user
      sessionstop_cmd  ${pkgs.xorg.sessreg}/bin/sessreg -d -l tty$(${pkgs.kbd}/bin/fgconsole) %user
    '';

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
            ${pkgs.feh}/bin/feh --no-fehbg --bg-max "$pape"
          else
            xsetroot -solid '#000000'
          fi
        fi
        ${pkgs.haskellPackages.xmobar}/bin/xmobar &
    '';

  };

}
