{ pkgs, ... }: {

  my.pia.enable = true;
  # eudroam, https://askubuntu.com/questions/464597/14-04-wifi-cant-connect-warn-connection-disconnected-reason-3
  boot.extraModprobeConfig = "options iwlwifi 11n_disable=1";

  networking.hostName = "nixos";
  networking.hostId = "c890f48c";

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 8000 8080 ];

  networking.enableIPv6 = false;
  networking.networkmanager.enable = true;
  users.extraGroups.networkmanager.members = [ "nick" "other" ];

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    wirelesstools
    iw
  ];
 
  users.extraGroups.wireshark.gid = 500;
  users.extraGroups.wireshark.members = [ "nick" ];

  # networking.wireless = {
  #   enable = true;
  #   userControlled.enable = true;
  #   interfaces = [ "wlp3s0" ];
  #   driver = "wext";
  # };

}
