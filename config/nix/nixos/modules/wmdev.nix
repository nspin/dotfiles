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
          ${cfg.command} &
          waitPID=$!
        '';
      }];
    };
  };
}
