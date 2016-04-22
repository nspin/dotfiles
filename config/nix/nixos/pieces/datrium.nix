{ ... }:

{
  services.xserver.displayManager.sessionCommands = ''
    sh /home/nick/dotfiles/src/x11/prewm.sh
    xmodmap /home/nick/dotfiles/src/x11/Xmodmap
    xset m 3/1 0
  '';

  services.vmwareGuest.enable = true;

  boot.kernel.sysctl = {
    "kernel.core_pattern" = "|/da/ToolsAndLibs/CodingScripts/zipcore.sh %p %r %u %s";
    "kernel.core_pipe_limit" = 64;
  };
}
