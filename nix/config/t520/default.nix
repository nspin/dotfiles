{ pkgs, lib, ... }: {

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  # boot.kernel.sysctl."kernel.yama.ptrace_scope" = lib.mkDefault "0";

  time.timeZone = "America/Boston";
  security.sudo.wheelNeedsPassword = false;

  users.groups = {
    dialout = {};
  };

}

  # programs.adb.enable = true;
  # users.extraUsers.nick.extraGroups = ["adbusers"];
