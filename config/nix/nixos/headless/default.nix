{ pkgs, lib, ... }: {

  boot.kernel.sysctl = {
    "kernel.yama.ptrace_scope" = lib.mkDefault "0";
  };

  time.timeZone = "America/Chicago";

  imports = [
    <dotfig/nix/nixos/common/config.nix>
  ];

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    my-vim
    git
    tmux
  ];

  users.extraUsers = {
    nick = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

}
