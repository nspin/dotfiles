{ pkgs, ... }:

{

  imports = [
    ./modules/core.nix
    ./modules/graphical/wmdev.nix
    ./modules/graphical/my-xmonad.nix
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
    # windowManager.my-xmonad.enable = true;
    desktopManager.xterm.enable = false;

    displayManager.slim.enable = true;
    displayManager.slim.theme = ./modules/graphical/slim-theme;

    displayManager.sessionCommands = ''
        xrdb -merge ${./modules/graphical/xresources}
        xmodmap ${./modules/graphical/Xmodmap}
        xset r rate 300 50
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
