{ config, pkgs, ... }:

{
  imports = [ pieces/common.nix ];

  services.xserver.displayManager.sessionCommands = ''
    sh /home/nick/dotfiles/src/x11/prewm.sh
    xmodmap /home/nick/dotfiles/src/x11/Xmodmap
  '';

  environment.systemPackages = import ./lists/min.nix pkgs
                            ++ import ./lists/full.nix pkgs
                            ++ import ./lists/current.nix pkgs;
}
