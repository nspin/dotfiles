{ pkgs, ... }:

{

  imports = [
    ./modules/core.nix
    ./modules/graphical/wmdev.nix
  ];

  boot.loader.grub.devices = [ "/dev/sda" ];

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

    windowManager.wmdev.enable = true;
    desktopManager.xterm.enable = false;

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

  };

  environment.systemPackages = with pkgs; [

    nix-repl
    nix-prefetch-scripts
    patchelf

    rlwrap

    coreutils
    gnumake
    which
    file

    gcc
    vimHugeX

    tmux
    git

    fzf

    xclip
    xorg.xkill
    xlibs.xmodmap
    xlibs.xmessage

    chromium

    dejavu_fonts

  ];

}
