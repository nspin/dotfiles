{ pkgs, lib, ... }: {

  boot.kernel.sysctl."kernel.yama.ptrace_scope" = lib.mkDefault "0";

  imports = [
    ./config.nix
    ./pkgs.nix
    ./xmonad
    # ./gnome
  ] ++ lib.optional (lib.pathExists <local>) <local>;

  virtualisation.virtualbox.guest.enable = true;
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

  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";
  };
  
  fonts = {
    enableFontDir = true;
    fontconfig.enable = true;
    fonts = [
      pkgs.dejavu_fonts
    ];
  };

}
