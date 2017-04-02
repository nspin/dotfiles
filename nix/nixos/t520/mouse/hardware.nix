{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    pmtools
    pmutils
    jmtpfs
    usbutils
    sysstat
  ];
 
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
