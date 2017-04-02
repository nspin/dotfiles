{ pkgs, lib, ... }: {

  imports = [
    ./hardware.nix
  ];

  services.xserver = {

    desktopManager.xfce.enable = true;

    displayManager.sddm.enable = true;
    displayManager.sddm.theme = "absdark";
    displayManager.sddm.package = pkgs.sddm.override {
      themes = [ (pkgs.callPackages ../mouse/sddm-themes/absdark.nix {}) ];
    };

    displayManager.sessionCommands = ''
      xrdb -merge ${./xresources}
      xmodmap ${./Xmodmap}
    '';

  };

}
