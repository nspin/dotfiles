{ config, pkgs, lib, ... }:

{

  networking.firewall.enable = lib.mkDefault false;

  services.openssh.enable = true;
  services.openssh.hostKeys = [
    { type = "ecdsa"; bits = "256"; path = "${config.my.config.dotfiles}/nix/nixos/bits/vbox/id_ecdsa"; }
  ];

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;
  users.extraUsers.x = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout" "vboxsf" "docker" ];
    password = "";
    openssh.authorizedKeys.keyFiles = [
      ./id_ecdsa.pub
    ];
  };

}
