{ pkgs, ... }:

{

  system.stateVersion = "16.03";

  imports = [
    ./modules/core.nix
    ./modules/graphical
    ./modules/media.nix
    ./modules/t520.nix
  ];

  environment.systemPackages = pkgs.mylib.gatherLists pkgs [
    ../lists/core.nix
#    ../lists/extra.nix
#    ../lists/math.nix
#    ../lists/sec.nix
#    ../lists/hs.nix
    ../lists/linux/core.nix
    ../lists/linux/graphical.nix
    ../lists/linux/hardware.nix
   ../lists/t520.nix
  ];
 
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    interfaces = [ "wlp3s0" ];
    driver = "wext";
  };

  my.graphical.isLaptop = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.systemWide = true;
  users.extraGroups.pulse-access.members = [ "nick" "other" "guest" "root" ];
  users.extraGroups.audio.members = [ "nick" "other" "guest" "root" ];

  networking.firewall.allowedTCPPorts = [ 8080 ];
}
