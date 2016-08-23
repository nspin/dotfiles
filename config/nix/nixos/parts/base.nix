{ pkgs, ... }:

{

  nixpkgs.config = import <dotfig/nix/pkgs/config.nix>;

  networking.hostName = "nixos";
  networking.hostId = "c890f48c";

  # time.timeZone = "America/New_York";
  time.timeZone = "Europe/Budapest";

  users.extraUsers = {
    nick = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "networkmanager" "transmission" ];
    };
    guest = {
      isNormalUser = true;
      uid = 1001;
    };
  };

  security.sudo = {
    wheelNeedsPassword = false;
    extraConfig = ''
      Defaults env_keep += "NIX_PATH"
    '';
  };

  services.openssh = {
    enable = true;
  };

  services.transmission = {
    enable = true;
    settings = {
      # TODO
      # download-dir = "/home/nick/Downloads";
      # download-dir = "/home/nick/trr";
      download-dir = "/var/lib/transmission/Downloads";
      incomplete-dir = "/var/lib/transmission/Downloads";
      incomplete-dir-enabled = true;
    };
  };

  services.mpd = {
    enable = true;
    musicDirectory = "/music";
  };

  environment.systemPackages = with pkgs; [
    transmission_remote_gtk
    haskellPackages.vimus
    ario
    gmpc
    mpc_cli
  ];

}
