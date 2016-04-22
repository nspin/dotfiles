{ ... }:

{
  services.xserver.displayManager.sessionCommands = builtins.readFile /home/nick/dotfiles/config/x11/prewm.sh;
}
