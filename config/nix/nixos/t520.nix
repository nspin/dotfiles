{ pkgs, ... }:

{
  imports = [
    ./pieces/common.nix
    ./pieces/normal.nix
    ./pieces/current.nix
  ];

  environment.systemPackages = pkgs.mylib.gatherLists pkgs [
    ../lists/core.nix
  ];
 
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.gummiboot.enable = true;

  # networking.wicd.enable = true;
  # networking.wpa_supplicant.enable = true;
  # networking.wireless.enable = true;
  # networking.wireless.userControlled.enable = true;

  # # networking.networkmanager.enable = true;
  # networking = {
  #   # interfaceMonitor.enable = false;
  #   wireless.enable = false; # Don't run wpa_supplicant (wicd will do it when necessary)
  #   useDHCP = false; # Don't run dhclient on wlan0
  #   wicd.enable = true;
  # };

  networking = {
    wireless.enable = false;
    wireless.userControlled = true;
  };

}
