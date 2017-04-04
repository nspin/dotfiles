{ pkgs, ... }: {

  services.xserver.synaptics = {
    enable = true;
    vertTwoFingerScroll = true;
    horizTwoFingerScroll = true;
    minSpeed = "0.6";
    maxSpeed = "10.0";
    accelFactor = "0.025";
  };

  services.acpid = {
    enable = true;
    handlers = {
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
    };
  };

}
