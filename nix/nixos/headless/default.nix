{ pkgs, lib, ... }: {

  imports = [
    <dotfiles/nix/nixos/common/config.nix>
  ];

  time.timeZone = "America/Chicago";

  security.sudo.wheelNeedsPassword = false;
  services.openssh.enable = true;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 443 ];

  boot.kernel.sysctl."kernel.yama.ptrace_scope" = lib.mkDefault "0";

  users.extraUsers = {
    nick = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" ];
    };
  };

  environment.systemPackages = with pkgs; [
    my-vim
    git
    tmux
    nix-repl
    nix-prefetch-scripts
    python35
    coreutils
    zip
    unzip
    file
    which
    fzf
    rlwrap
    uttyl
    fznode
    certbot
  ];

}
