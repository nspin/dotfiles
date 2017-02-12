{ pkgs, ... }:

{

  nixpkgs.config = import <dotfig/nix/pkgs/config.nix>;

  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
    "dotfig=/cfg/dotfiles/config"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];


  networking.hostName = "nixos";
  networking.hostId = "c890f48c";
  networking.firewall.enable = true;

  users.extraUsers = {
    nick = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "wireshark" ];
    };
  };

  security.sudo = {
    wheelNeedsPassword = false;
    extraConfig = ''
      Defaults env_keep += "EDITOR"
      Defaults env_keep += "VISUAL"

      Defaults env_keep += "VIM"
      Defaults env_keep += "VIMRUNTIME"
      Defaults env_keep += "FZF_DEFAULT_OPTS"

      Defaults env_keep += "DOTFILES"
      Defaults env_keep += "VIM_BUNDLE"
      Defaults env_keep += "VIM_PLUGIN_PATH"
      Defaults env_keep += "MY_LOCAL"

      Defaults env_keep += "NIX_PATH"
    '';
  };

  environment.variables = rec {

    EDITOR = "vim";
    VISUAL = "vim";
    BROWSER = "chromium";

    VIM = DOTFILES + "/config/vim";
    FZF_DEFAULT_OPTS = "--reverse";

    DOTFILES = "/cfg/dotfiles";
    VIM_BUNDLE = "/cfg/vim-bundle/bundle";
    VIM_PLUGIN_PATH = "${pkgs.vimPlugins.youcompleteme}/share/vim-plugins/youcompleteme";
    MY_LOCAL = "/cfg/local";

  };

  environment.extraInit = ''
    export PATH="$PATH:$DOTFILES/bin:$DOTFILES/bin/linux:$MY_LOCAL/bin"
    export VIMRUNTIME="${pkgs.vimHugeX}/share/vim/vim[0-9][0-9]";
  '';

  # environment.etc = {
  #   "tmux.conf" = {
  #     source = <dotfig/multiplexers/tmux.conf>;
  #   };
  #   "inputrc" = { # or INPUTRC
  #     source = <dotfig/line-editors/inputrc>;
  #   };
  # };

  services.physlock = {
    enable = true;
    user = "nick";
    lockOn.suspend = true;
    lockOn.hibernate = true;
  };

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

}
