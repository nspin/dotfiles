{ pkgs, ... }:

{

  imports = [
    ./config.nix
    ./pkgs.nix
  ];

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  users.mutableUsers = false;
  users.users.root.password = "";

}
