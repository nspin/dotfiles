{ pkgs, lib, ... }: {

  imports = [
    ./config.nix
    ./pkgs.nix
  ];

  security.sudo.wheelNeedsPassword = false;
  network.firewall.enabe = true;
  services.openssh.enable = true;
  services.openssh.openFirewall = true;

  time.timeZone = "America/Boston";

  users.extraUsers = {
    nick = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "vboxsf" "docker" ];
    };
  };

}
