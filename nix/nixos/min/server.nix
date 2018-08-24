{ config, pkgs, lib, ... }:

with lib;

let

  cfg = config.my;

in {

  imports = [
    ./config.nix
    ./pkgs.nix
  ];

  options = {

    my.keyFiles = mkOption {
      type = types.listOf types.path;
    };

  };

  config = {

    services.openssh.enable = true;
    services.openssh.openFirewall = true;
    services.openssh.passwordAuthentication = false;

    security.sudo.wheelNeedsPassword = false;

    users.mutableUsers = false;
    users.extraUsers.x = {
      uid = 1000;
      isNormalUser = true;
      initialHashedPassword = "nope";
      extraGroups = [ "wheel" "docker" ];
      openssh.authorizedKeys.keyFiles = cfg.keyFiles;
    };

  };

}
