{ config, pkgs, lib, ... }:

with lib;

let

  cfg = config.my.zerofree;

in {

  options = {

    my.zerofree.enable = mkEnableOption "zerofree";

    my.zerofree.do = mkOption {
      type = types.bool;
      default = false;
    };

  };

  config = mkIf cfg.enable {

    boot.kernelParams = optional cfg.do "zerofree";

    boot.initrd.extraUtilsCommands = ''
      copy_bin_and_libs ${pkgs.zerofree}/bin/zerofree
    '';

    boot.initrd.postDeviceCommands = ''
      for o in $(cat /proc/cmdline); do
          case $o in
              zerofree)
                  cmd="zerofree on /dev/disk/by-label/nixos"
                  running "$cmd" ...
                  zerofree -v /dev/disk/by-label/nixos
                  ... done
                  break
                  ;;
          esac
      done
    '';

  };

}
