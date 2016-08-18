{ config, lib, pkgs, ... }:

with lib;

let

  acpiConfDir = pkgs.runCommand "acpi-events" {}
    ''
      mkdir -p $out
      fn=$out/test
      echo "event=.*" > $fn
      echo "action=${pkgs.utillinux}/bin/logger works " >> $fn
    '';

in

{

  ###### interface

  options = {

    services.myAcpid = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable the ACPI daemon.";
      };

    };

  };


  ###### implementation

  config = mkIf config.services.myAcpid.enable {

    systemd.services.myAcpid = {
      description = "ACPI Daemon";

      wantedBy = [ "multi-user.target" ];
      after = [ "systemd-udev-settle.service" ];

      path = [ pkgs.acpid ];

      serviceConfig = {
        Type = "forking";
      };

      unitConfig = {
        ConditionVirtualization = "!systemd-nspawn";
        ConditionPathExists = [ "/proc/acpi" ];
      };

      script = "acpid -l --confdir ${acpiConfDir}";
    };

  };

}
