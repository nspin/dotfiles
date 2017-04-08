{ pkgs, ... }: {

  imports = [ ../pia ];

  networking.hostName = "nixos";
  networking.hostId = "c890f48c";

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 8080 ];

  networking.enableIPv6 = false;
  networking.networkmanager.enable = true;
  users.extraGroups.networkmanager.members = [ "nick" "other" ];

  services.openssh.enable = true;
  services.samba.enable = true;

  my.pia.enable = true;
  my.pia.servers = {
    sw = "sweden";
    mw = "us-midwest";
  };

  environment.systemPackages = with pkgs; [
    wirelesstools
    iw
    sshfsFuse
    rsync
    telnet
    wireshark

    samba
  ];
 
  users.extraGroups.wireshark.gid = 500;
  users.extraGroups.wireshark.members = [ "nick" ];

  security.wrappers = {
    dumpcap = {
      program = "dumpcap";
      source = "${pkgs.wireshark}/bin/dumpcap";
      owner = "root";
      group = "wireshark";
      setuid = true;
      setgid = false;
      permissions = "u+rx,g+x";
    };
  };

  # networking.wireless = {
  #   enable = true;
  #   userControlled.enable = true;
  #   interfaces = [ "wlp3s0" ];
  #   driver = "wext";
  # };

}
