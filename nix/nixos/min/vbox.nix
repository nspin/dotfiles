{ pkgs, lib, ... }:

{

  imports = [
    ./config.nix
    ./pkgs.nix
  ];

  networking.firewall.enable = false;

  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;
  users.extraUsers.x = {
    uid = 1000;
    isNormalUser = true;
    password = "";
    extraGroups = [ "wheel" "docker" "vboxsf" ];
  };

  virtualisation.virtualbox.guest.enable = true;

  boot.growPartition = true;
  boot.loader.grub.device = "/dev/sda";
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
  };

}
