{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  environment.systemPackages = pkgs.mylib.gatherLists pkgs [
    ./lists/core.nix
    ./lists/linux.nix
    # ./lists/huge.nix
    # ./lists/current.nix
    ./lists/520.nix
  ];
 
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.gummiboot.enable = true;

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    interfaces = [ "wlp3s0" ];
    driver = "wext";
  };

  system.stateVersion = "16.03";

  services.upower.enable = true;

  services.xserver.synaptics = {
    enable = true;
    vertTwoFingerScroll = true;
    horizTwoFingerScroll = true;
    minSpeed = "0.6";
    maxSpeed = "10.0";
    accelFactor = "0.025";
  };

}
