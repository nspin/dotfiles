{ pkgs, lib, config, ... }:

let

  cfg = config.services.xserver.windowManager.my-xmonad;

in with lib; {

  options = {
    services.xserver.windowManager.my-xmonad = {
      enable = mkEnableOption "my-xmonad";
      isLaptop = mkOption {
        default = false;
        example = true;
        type = lib.types.bool;
        description = "Is laptop?";
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver.windowManager = {
      session = [{
        name = "xmonad";
        start =
          let
            my-xmonad = (pkgs.haskellPackages.callPackage <dotfiles/config/xmonad> {}) cfg.isLaptop;
          in ''
            # logdir=/var/log/wmdev
            # mkdir -p $logdir
            # ${my-xmonad}/bin/xmonad > $logdir/out.log 2> $logdir/err.log &
            ${my-xmonad}/bin/xmonad &
            waitPID=$!
          '';
      }];
    };
  };

}
