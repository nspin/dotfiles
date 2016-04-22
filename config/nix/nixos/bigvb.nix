{ config, pkgs, ... }:

{
  imports = [
    ./pieces/common.nix
    ./pieces/normal.nix
  ];

  environment.systemPackages = pkgs.mylib.gatherLists pkgs [
    ../lists/corenix
    ../lists/huge.nix
    ../lists/current.nix
  ];
}
