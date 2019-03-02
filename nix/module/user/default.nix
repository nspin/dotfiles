{ config, pkgs, lib, ... }:

with lib;

{

  config = {

    security.sudo.wheelNeedsPassword = false;

    users.extraUsers.x = {
      uid = 1000;
      isNormalUser = true;
      extraGroups = [ "wheel" "dialout" "vboxsf" "docker" ];
    };

  };

}
