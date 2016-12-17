{ pkgs, ... }:

{

  # time.timeZone = "America/New_York";
  time.timeZone = "Europe/Budapest";

  services.physlock = {
    enable = true;
    user = "nick";
    lockOn.suspend = true;
    lockOn.hibernate = true;
  };

  users.extraUsers = {
    guest = {
      isNormalUser = true;
      uid = 1001;
    };
    other = {
      isNormalUser = true;
      uid = 1002;
      extraGroups = [ "wheel" "networkmanager" "transmission" ];
    };
  };

  services.openssh = {
    enable = true;
  };

  services.transmission = {
    enable = true;
    settings = {
      # TODO
      download-dir = "/var/lib/transmission/Downloads";
      incomplete-dir = "/var/lib/transmission/Downloads";
      incomplete-dir-enabled = true;
    };
  };

  services.mpd = {
    enable = true;
    musicDirectory = "/music";
    extraConfig = ''
      mixer_type "software"
    '';
  };

  environment.systemPackages = with pkgs; [
    transmission_remote_gtk
    # haskellPackages.vimus
    ario
    gmpc
    mpc_cli
  ];

}
