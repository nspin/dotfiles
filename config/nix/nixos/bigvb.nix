{ pkgs, ... }:

{
  imports = [
    ./parts/base.nix
    ./parts/graphical.nix
  ];

  environment.systemPackages = pkgs.mylib.gatherLists pkgs [
    ../lists/core.nix
    ../lists/linux/core.nix
    ../lists/linux/graphical.nix
  ];

  boot.loader.grub.device = "/dev/sda";

}
