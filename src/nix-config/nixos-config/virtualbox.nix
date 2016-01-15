{ config, pkgs, ... }:

{
  imports =
    [ lib/common.nix
      lib/max.nix
    ];

  services.xserver.displayManager.sessionCommands = ''
    sh /home/nick/dotfiles/src/x11/prewm.sh
    xmodmap /home/nick/dotfiles/src/x11/Xmodmap
  '';
}
