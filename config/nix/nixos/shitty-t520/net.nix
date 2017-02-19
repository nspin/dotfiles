{ pkgs, ... }: {

  imports = [ ../common/pia.nix ];

  networking.hostName = "nixos";
  networking.hostId = "c890f48c";

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 8080 ];

  services.openssh.enable = true;

  my.pia.enable = true;
  my.pia.server = "sweden";

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    interfaces = [ "wlp3s0" ];
    driver = "wext";
  };

  environment.systemPackages = with pkgs; [
    wpa_supplicant
    wpa_supplicant_gui
    wirelesstools
    iw
    sshfsFuse
    rsync
    telnet
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
