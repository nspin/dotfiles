{ pkgs, ... }:

{
  imports = [
    ./parts/base.nix
    ./parts/graphical.nix
  ];

  environment.systemPackages = pkgs.mylib.gatherLists pkgs [
    ../lists/core.nix
    ../lists/extra.nix
    ../lists/hs.nix
    ../lists/linux/core.nix
    ../lists/linux/graphical.nix
    ../lists/linux/hardware.nix
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

  # services.opensmtpd = {
  #   enable = true;
  #   serverConfiguration = ''
  #     listen on 127.0.0.1 port 25 hostname somehost.com
  #   '';
  # };

}
