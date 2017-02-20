{ pkgs, ... }: {

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

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.systemWide = true;
  users.extraGroups.pulse-access.members = [ "nick" "other" "guest" "root" ];
  users.extraGroups.audio.members = [ "nick" "other" "guest" "root" ];

  environment.systemPackages = with pkgs; [
    transmission_remote_gtk
    ario
    gmpc
    mpc_cli
  ];

}
