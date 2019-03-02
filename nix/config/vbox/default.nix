{ config, pkgs, lib, ... }:

{

  my.headless.enable = true;
  my.headless.insecure.enable = true;

  virtualisation.virtualbox.guest.enable = true;

  boot.growPartition = true;
  boot.loader.grub.device = "/dev/sda";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
  };

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];

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

}
