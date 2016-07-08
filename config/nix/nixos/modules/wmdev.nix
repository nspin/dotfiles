{pkgs, lib, config, ...}:

with lib;
let
  inherit (lib) mkOption mkIf optionals literalExample;
  cfg = config.services.xserver.windowManager.wmdev;
in
{
  options = {
    services.xserver.windowManager.wmdev = {
      enable = mkEnableOption "wmdev";
      logDir = mkOption {
        default = "/home/nick/log/wmdev";
        description = ''
          Directory for log files
        '';
      };
      command = mkOption {
        default = "true";
        description = ''
          Path to development binary
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    services.xserver.windowManager = {
      session = [{
        name = "wmdev";
        start = ''
          source $HOME/dotfiles/config/sh/env.sh
          mkdir -p ${cfg.logDir}
          ${cfg.command} > ${cfg.logDir}/out.log 2> ${cfg.logDir}/err.log &
          waitPID=$!
        '';
      }];
    };
  };
}
