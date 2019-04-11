{ pkgs, lib, ... }: {

  my.env.pkgs.tui = 1;
  my.env.pkgs.gui = 1;
  my.gui.enable = true;
  my.gui.gnome.enable = true;
  # my.gui.xfce.enable = true;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  # boot.kernel.sysctl."kernel.yama.ptrace_scope" = lib.mkDefault "0";

  security.sudo.wheelNeedsPassword = false;

  users.groups = {
    dialout = {};
  };

}
