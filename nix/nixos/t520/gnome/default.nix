{ pkgs, config, lib, ... }: {

  imports = [
    ./pkgs.nix
    ./hardware.nix
  ];

  services.xserver = {

    desktopManager.gnome3.enable = true;
    displayManager.gdm.enable = true;

    displayManager.sessionCommands = ''
      xrdb -merge ${./xresources}
      xmodmap ${./Xmodmap}
      xset r rate 300 50
    '';

  };

}
