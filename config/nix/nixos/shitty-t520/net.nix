{ pkgs, ... }: {

  imports = [ ../common/pia ];

  networking.hostName = "nixos";
  networking.hostId = "c890f48c";

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 8080 ];

  networking.enableIPv6 = false;
  networking.networkmanager.enable = true;
  users.extraGroups.networkmanager.members = [ "nick" ];

  services.openssh.enable = true;

  my.pia.enable = true;
  my.pia.servers = {
    sw = "sweden";
    mw = "us-midwest";
  };

  # my.pia.server = "sweden";
  # my.pia.server = "us-midwest";

  # networking.wireless = {
  #   enable = true;
  #   userControlled.enable = true;
  #   interfaces = [ "wlp3s0" ];
  #   driver = "wext";
  # };

  environment.systemPackages = with pkgs; [
    wpa_supplicant
    wpa_supplicant_gui
    wirelesstools
    iw
    sshfsFuse
    rsync
    telnet
    wireshark
  ];
 
  users.extraGroups.wireshark.gid = 500;
  users.extraGroups.wireshark.members = [ "nick" ];

  security.setuidOwners = [
    { program = "dumpcap";
      source = "${pkgs.wireshark}/bin/dumpcap";
      owner = "root";
      group = "wireshark";
      setuid = true;
      setgid = false;
      permissions = "u+rx,g+x";
    }
  ];

}
