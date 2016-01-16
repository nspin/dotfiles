{ config, pkgs, ... }:

{
  imports = [ pieces/common.nix ];

  services.xserver.displayManager.sessionCommands = ''
    sh /home/nick/dotfiles/src/x11/prewm.sh
    xmodmap /home/nick/dotfiles/src/x11/Xmodmap
    xset m 3/1 0
  '';

  environment.systemPackages = import ./lists/min.nix pkgs
                            ++ import ./lists/full.nix pkgs
                            ++ import ./lists/current.nix pkgs;
  ];

  services.vmwareGuest.enable = true;

  boot.kernel.sysctl = {
    "kernel.core_pattern" = "|/da/ToolsAndLibs/CodingScripts/zipcore.sh %p %r %u %s";
    "kernel.core_pipe_limit" = 64;
  };
}
