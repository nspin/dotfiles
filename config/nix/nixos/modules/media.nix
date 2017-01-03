{ pkgs, ... }:

{

  time.timeZone = "America/New_York";
  # time.timeZone = "Europe/Budapest";

  users.extraUsers = {
    guest = {
      isNormalUser = true;
      uid = 1001;
    };
    other = {
      isNormalUser = true;
      uid = 1002;
      extraGroups = [ "wheel" ];
    };
  };

  services.transmission = {
    enable = true;
    settings = {
      download-dir = "/var/lib/transmission/Downloads";
      incomplete-dir = "/var/lib/transmission/Downloads";
      incomplete-dir-enabled = true;
    };
  };

  users.extraGroups.transmission.members = [ "nick" "other" ];

  services.mpd = {
    enable = true;
    musicDirectory = "/music";
    extraConfig = ''
      mixer_type "software"
    '';
  };

  environment.systemPackages = with pkgs; [
    transmission_remote_gtk
    ario
    gmpc
    mpc_cli
  ];

}
