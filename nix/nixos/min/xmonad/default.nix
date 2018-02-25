{ pkgs, ... }:

let

  bg = pkgs.fetchurl {
    url = "https://mk0kzsc0r04nd5wp46sq.kinstacdn.com/wp-content/uploads/2012/11/vertikal.jpg";
    sha256 = "1lhglq679k2wj9lfy8qirb33n0w2gixsbzyca4rhk8jz5xiq63hm";
  };

in {

  imports = [
    ./pkgs.nix
  ];

  services.xserver = {

    displayManager.auto.enable = true;
    displayManager.auto.user = "nick";
    displayManager.sessionCommands = ''
        xrdb -merge ${./xresources}
        xmodmap ${./Xmodmap}
        xset r rate 300 50
        xsetroot -cursor_name left_ptr
        ${pkgs.feh}/bin/feh --no-fehbg --bg-max ${bg}
    '';

    desktopManager.default = "mine";
    desktopManager.xterm.enable = false;
    desktopManager.session = [ {
      name = "mine";
      bgSupport = true;
      start = "";
    } ];

    windowManager.default = "xmonad";
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;

    # displayManager.slim.enable = true;
    # displayManager.slim.theme = ./slim-theme;
    # displayManager.slim.extraConfig = ''
    #   sessionstart_cmd ${pkgs.xorg.sessreg}/bin/sessreg -a -l tty$(${pkgs.kbd}/bin/fgconsole) %user
    #   sessionstop_cmd  ${pkgs.xorg.sessreg}/bin/sessreg -d -l tty$(${pkgs.kbd}/bin/fgconsole) %user
    # '';

  };

}
