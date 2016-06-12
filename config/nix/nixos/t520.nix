{ pkgs, ... }:

{
  imports = [
    ./pieces/common.nix
    ./pieces/normal.nix
    ./pieces/current.nix
  ];

  environment.systemPackages = pkgs.mylib.gatherLists pkgs [
    ../lists/core.nix
  ];
 
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.gummiboot.enable = true;

}
