{ pkgs, lib, ... }: {

  imports = [
    ./config.nix
    ./pkgs.nix
  ];

  security.sudo.wheelNeedsPassword = false;
  services.openssh.enable = true;
  time.timeZone = "America/Chicago";

  users.extraUsers = {
    nick = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "vboxsf" "docker" ];
    };
  };

}
