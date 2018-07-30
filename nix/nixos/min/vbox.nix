{ pkgs, ... }:

{

  virtualisation.virtualbox.guest.enable = true;

  boot.growPartition = true;
  boot.loader.grub.device = "/dev/sda";
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
  };

}
