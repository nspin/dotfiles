{ config, pkgs, ... }:

{
  services.xserver.displayManager.sessionCommands = ''
    sh /home/nick/dotfiles/src/x11/prewm.sh
    xmodmap /home/nick/dotfiles/src/x11/Xmodmap
    xset m 3/1 0
  '';
}
