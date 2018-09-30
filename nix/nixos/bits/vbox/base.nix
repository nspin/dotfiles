{ config, pkgs, lib, ... }:

{

  networking.firewall.enable = false;

  services.openssh.enable = true;
  services.openssh.hostKeys = [
    { type = "ecdsa"; bits = "256"; path = "${config.my.config.dotfiles}/nix/nixos/min/vbox/id_ecdsa"; }
  ];

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;
  users.extraUsers.x = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "vboxsf" ];
    password = "";
    openssh.authorizedKeys.keyFiles = [
      ./id_ecdsa.pub
    ];
  };

}