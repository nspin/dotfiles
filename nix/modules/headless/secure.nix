{ config, pkgs, lib, ... }:

with lib;

let

  cfg = config.my.headless.secure;

in {

  options = {

    my.headless.secure.enable = mkEnableOption "secure headless";

    my.headless.secure.keyFiles = mkOption {
      type = types.listOf types.path;
      default = [];
    };

  };

  config = mkIf cfg.enable {

    services.openssh.passwordAuthentication = false;

    users.extraUsers.x = {
      initialHashedPassword = "nope";
      openssh.authorizedKeys.keyFiles = cfg.keyFiles;
    };

  };

}
