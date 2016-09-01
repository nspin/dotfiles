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
      start = mkOption {
        default = "true";
        description = ''
          The world is yours
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    services.xserver.windowManager = {
      session = [{
        name = "wmdev";
        inherit (cfg) start;
      }];
    };
  };
}
