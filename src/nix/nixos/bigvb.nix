{ config, pkgs, ... }:

{
  imports = [
    ./pieces/common.nix
    ./pieces/virtualbox.nix
  ];

  environment.systemPackages = pkgs.mylib.gatherLists pkgs [
    ../lists/min.nix
    ../lists/full.nix
    ../lists/current.nix
  ];

}
