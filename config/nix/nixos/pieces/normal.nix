{ ... }:

{
  services.xserver.displayManager.sessionCommands = builtins.readFile <dotfig/x11/prewm.sh>;
}
