{ pkgs, ... }:

{
  imports = [
    ./base.nix
    ./graphical.nix
    ./my-acpid.nix
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

  # TODO pass %e to scripts in nixpkgs
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
      play = {
        event = "cd/play.*";
        action = "${pkgs.mpc_cli}/bin/mpc toggle";
      };
      stop = {
        event = "cd/stop.*";
        action = "${pkgs.mpc_cli}/bin/mpc stop";
      };
      next = {
        event = "cd/next.*";
        action = "${pkgs.mpc_cli}/bin/mpc next";
      };
      prev = {
        event = "cd/prev.*";
        action = "${pkgs.mpc_cli}/bin/mpc prev";
      };
      mic = {
        event = "button/f20.*";
        action = "";
      };
      bat = {
        event = "button/battery.*";
        action = "";
      };
      lock = {
        event = "button/screenlock.*";
        action = "systemctl start physlock";
      };
      wat = {
        event = "video/switchmode.*";
        action = "";
      };
    };
  };

}
