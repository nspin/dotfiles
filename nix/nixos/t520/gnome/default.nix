{ pkgs, config, lib, ... }: {

  imports = [
    ./pkgs.nix
    ./hardware.nix
  ];

  environment.systemPackages = with pkgs; [
    (callPackage ./xstuff {})
  ];

  services.xserver = {
    desktopManager.gnome3.enable = true;
    displayManager.gdm.enable = true;
    displayManager.sessionCommands = ''
      xrdb -merge ${./xresources}
    '';
  };

}
