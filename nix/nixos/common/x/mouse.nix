{ pkgs, ... }: {

  imports = [ ./common.nix ];

  services.xserver = {

    desktopManager.xfce.enable = true;

    displayManager.sessionCommands = ''
      xrdb -merge ${./xresources}
      xmodmap ${./Xmodmap}
    '';

  };

}
