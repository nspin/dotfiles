{ pkgs, lib, config, ... }:

let

  cfg = config.services.xserver.windowManager.wmdev;

in with lib; {

  options = {
    services.xserver.windowManager.wmdev = {
      enable = mkEnableOption "wmdev";
      exe = mkOption {
        default = "/wmdev/wm";
        type = lib.types.path;
        description = "Path to wm";
      };
      logdir = mkOption {
        default = "/wmdev/log";
        type = lib.types.path;
        description = "Path to log dir";
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver.windowManager = {
      session = [{
        name = "wmdev";
        start = ''
          mkdir -p ${cfg.logdir}
          ${cfg.exe} > ${cfg.logdir}/out.log 2> ${cfg.logdir}/err.log &
          pid=$!
          xterm &
          waitPID=$pid
        '';
      }];
    };
  };

}
