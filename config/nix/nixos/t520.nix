{ pkgs, ... }:

{
  imports = [
    ./pieces/common.nix
    ./pieces/normal.nix
    ./pieces/current.nix
  ];

  environment.systemPackages = pkgs.mylib.gatherLists pkgs [
    ../lists/core.nix
    # ../lists/huge.nix
    # ../lists/current.nix
  ];
 
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.gummiboot.enable = true;

  networking = {
    wireless.enable = false;
    wireless.userControlled.enable = true;
  };

  system.stateVersion = "16.03";

}
