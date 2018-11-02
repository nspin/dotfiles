{ config, pkgs, lib, ... }:

{

  imports = [
    ./base.nix
  ];

  virtualisation.virtualbox.guest.enable = true;

  boot.growPartition = true;
  boot.loader.grub.device = "/dev/sda";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
  };

  swapDevices = [{
    device = "/dev/disk/by-label/swap";
  }];

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

}
