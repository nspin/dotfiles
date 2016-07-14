{ pkgs, ... }:

{
  imports = [
    ./parts/base.nix
  ];

  environment.systemPackages = pkgs.mylib.gatherLists pkgs [
    ./lists/core.nix
  ];

  boot.loader.grub.device = "/dev/sda";
}
