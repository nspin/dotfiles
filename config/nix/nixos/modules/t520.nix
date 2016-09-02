{ pkgs, ... }:

{

  services.upower.enable = true;

  services.xserver.synaptics = {
    enable = true;
    vertTwoFingerScroll = true;
    horizTwoFingerScroll = true;
    minSpeed = "0.6";
    maxSpeed = "10.0";
    accelFactor = "0.025";
  };

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
