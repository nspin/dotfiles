{ pkgs, lib, ... }: {

  system.stateVersion = "17.03";

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  # boot.kernel.sysctl = {
  #   "kernel.yama.ptrace_scope" = lib.mkDefault "0";
  # };

  time.timeZone = "America/Chicago";
  services.physlock.enable = true;
  security.sudo.wheelNeedsPassword = false;

  imports = [
    ./net.nix
    ./media.nix
    ./hardware.nix
    ./pkgs.nix
    ./gpkgs.nix
    ../common/config.nix
    # ../common/x/mouse.nix
    ../common/x/fingers.nix
  ] ++ (lib.optional (builtins.pathExists <dotfiles/../local>) <dotfiles/../local>);

  users.extraUsers = {
    nick = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" ];
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
  };

}
