{ config, pkgs, lib, ... }:

with lib;

let

  cfg = config.my.headless;

in {

  imports = [
    ./secure.nix
    ./insecure.nix
  ];

  options = {

    my.headless.enable = mkEnableOption "headless";

  };

  config = mkIf cfg.enable {

    users.mutableUsers = false;

    services.openssh.enable = true;

  };

}
