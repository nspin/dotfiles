{ pkgs, lib, ... }: {

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  # boot.kernel.sysctl."kernel.yama.ptrace_scope" = lib.mkDefault "0";

  time.timeZone = "America/Boston";
  security.sudo.wheelNeedsPassword = false;

  imports = [

    ../extra-pkgs.nix
    ../gui
    ../gui/extra-pkgs.nix

    ./net.nix
    ./media.nix
    ./tpkgs.nix
    ./gpkgs.nix

  ];

  users.extraUsers = {
    nick = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "dialout" "docker" ];
    };
    guest = {
      isNormalUser = true;
      uid = 1001;
    };
    other = {
      isNormalUser = true;
      uid = 1002;
      extraGroups = [ "wheel" ];
    };
    iso = {
      isNormalUser = true;
      uid = 1003;
      extraGroups = [ "wheel" ];
    };
  };

  users.groups = {
    dialout = {};
  };

}
