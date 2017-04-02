{ pkgs, ... }: {

  services.upower.enable = true;

  # TODO pass %e to scripts in nixpkgs
  services.acpid = {
    enable = true;
    handlers =
      let
        vol = action: ''
          ${pkgs.alsaUtils}/bin/amixer sset Master ${action}
          # # for finding a user with a running pulse server
          # user=$(who | sed -nr 's/^([^ ]+) +tty7.*$/\1/p')
          # if [ -n "$user" ]; then
          #   su "$user" -c "${pkgs.alsaUtils}/bin/amixer sset Master ${action}"
          # fi
        '';
      in {
        mute = {
          event = "button/mute.*";
          action = vol "toggle";
        };
        vup = {
          event = "button/volumeup.*";
          action = vol "2%+";
        };
        vdown = {
          event = "button/volumedown.*";
          action = vol "2%-";
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
