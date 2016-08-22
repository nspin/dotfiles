{ pkgs, ... }:

{
  imports = [
    ./parts/base.nix
    ./parts/graphical.nix
    ./modules/my-acpid.nix
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
  boot.loader.systemd-boot.enable = true;

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

  services.acpid = {
    enable = true;
    handlers = {
      mute = {
        event = "button/mute.*";
        action = "${pkgs.alsaUtils}/bin/amixer set Master toggle";
      };
      vup = {
        event = "button/volumeup.*";
        action = "${pkgs.alsaUtils}/bin/amixer set Master 5%+";
      };
      vdown = {
        event = "button/volumedown.*";
        action = "${pkgs.alsaUtils}/bin/amixer set Master 5%-";
      };
    };
  };

}
