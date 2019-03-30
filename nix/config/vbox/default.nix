{ config, pkgs, lib, ... }:

{

  my.headless.enable = true;
  my.headless.insecure.enable = true;
  my.zerofree.enable = true;

  virtualisation.virtualbox.guest.enable = true;

  boot.growPartition = true;
  boot.loader.grub.device = "/dev/sda";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    autoResize = true;
  };

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];

}
