{pkgs, lib, config, ...}:

with lib;
let
  inherit (lib) mkOption mkIf optionals literalExample;
  cfg = config.services.xserver.windowManager.anywm;
in
{
  options = {
    services.xserver.windowManager.anywm = {
      enable = mkEnableOption "anywm";
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
        name = "anywm";
        inherit (cfg) start;
      }];
    };
  };
}
