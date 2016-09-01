{ pkgs, ... }:

{
  imports = [
    ./wmdev.nix
  ];

  fonts = {
    enableFontDir = true;
    fontconfig.enable = true;
    fonts = [
      pkgs.dejavu_fonts
    ];
  };

  services.xserver = {

    autorun = true;
    enable = true;
    layout = "us";

    displayManager.slim = {
      enable = true;
      # defaultUser = "nick";
      # theme = pkgs.fetchurl {
      #     url = "https://github.com/jagajaga/nixos-slim-theme/archive/Final.tar.gz";
      #     sha256 = "4cab5987a7f1ad3cc463780d9f1ee3fbf43603105e6a6e538e4c2147bde3ee6b";
      # };
      theme = ./slim-theme;
    };

    displayManager.sessionCommands = ''
        xrdb -merge ${./x11/xresources}
        xmodmap ${./x11/Xmodmap}
        xset r rate 300 50
        xsetroot -cursor_name left_ptr&
        pape=""
        for img in ~/.wallpaper.{png,jpg}; do
            if [ -f "$img" ]; then
                pape="$img"
            fi
        done
        if [ -n "$pape" ]; then
            feh --bg-max "$pape"
        else
          xsetroot -solid '#000000'
        fi
    '';

    windowManager.wmdev =
      let my-xmonad = pkgs.haskellPackages.callPackage <dotfig/xmonad> {};
      in {
        enable = true;
        start = ''
          # logdir=/var/log/wmdev
          # mkdir -p $logdir
          # ${my-xmonad}/bin/xmonad > $logdir/out.log 2> $logdir/err.log &
          ${my-xmonad}/bin/xmonad
          waitPID=$!
        '';
      };

    desktopManager.xterm.enable = false;

    # desktopManager.kde4.enable = true;
    # displayManager.kdm.enable = true;

  };
}
