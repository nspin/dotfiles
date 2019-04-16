{ config, pkgs, lib, ... }:

with lib;

let

  cfg = config.my.headless.insecure;

in {

  options = {

    my.headless.insecure.enable = mkEnableOption "insecure headless";

  };

  config = mkIf cfg.enable {

    networking.firewall.enable = lib.mkDefault false;

    services.openssh.hostKeys = [
      # TODO this won't work when id_ecda is in the nix store
      { type = "ecdsa"; bits = "256"; path = "${config.my.env.paths.dotfiles}/nix/modules/headless/id_ecdsa"; }
    ];

    users.extraUsers.x = {
      password = "";
      openssh.authorizedKeys.keyFiles = [
        ./id_ecdsa.pub
      ];
    };

  };

}
