{ pkgs, ... }:

{

  imports = [
    ./modules/base.nix
    ./modules/graphical
    ./modules/t520.nix
  ];

  environment.systemPackages = pkgs.mylib.gatherLists pkgs [
    ../lists/core.nix
    ../lists/extra.nix
    ../lists/math.nix
    ../lists/sec.nix
    ../lists/hs.nix
    ../lists/linux/core.nix
    ../lists/linux/graphical.nix
    ../lists/linux/hardware.nix
  ];
 
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    interfaces = [ "wlp3s0" ];
    driver = "wext";
  };

  system.stateVersion = "16.03";

}
