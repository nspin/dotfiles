{ config, pkgs, lib, ... }:

{

  my.headless.enable = true;
  my.headless.insecure.enable = true;
  my.zerofree.enable = true;

  virtualisation.virtualbox.guest.enable = true;

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];

}
