{ pkgs, ... }:

{

  nixpkgs.config = import <dotfig/nix/pkgs/config.nix>;

  networking.hostName = "nixos";
  networking.hostId = "c890f48c";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8080 ];
  };


  users.extraUsers = {
    nick = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "networkmanager" "transmission" ];
    };
  };
  security.sudo = {
    wheelNeedsPassword = false;
    extraConfig = ''
      Defaults env_keep += "NIX_PATH"
      Defaults env_keep += "VISUAL"
      Defaults env_keep += "EDITOR"
      Defaults env_keep += "CFGDIR"
      Defaults env_keep += "VIM"
      Defaults env_keep += "VIMRUNTIME"
      Defaults env_keep += "VIMBUNDLE"
      Defaults env_keep += "VIM_PLUGIN_PATH"
    '';
  };

  environment.variables = rec {
    VISUAL = "vim";
    EDITOR = "vim";
    BROWSER = "chromium";
    CFGDIR = "/cfg";
    VIM = CFGDIR + "/dotfiles/config/vim";
    VIMRUNTIME = "${pkgs.vimHugeX}/share/vim/vim74";
    VIMBUNDLE = CFGDIR + "/vim-bundle/bundle";
    VIM_PLUGIN_PATH = "${pkgs.vimPlugins.youcompleteme}/share/vim-plugins/youcompleteme";
    FZF_DEFAULT_OPTS = "--reverse";
  };

  environment.extraInit = ''
    export PATH="$PATH:$CFGDIR/dotfiles/bin:$CFGDIR/dotfiles/bin/linux:$CFGDIR/local/bin"
    export NIX_PATH="$NIX_PATH:dotfig=$CFGDIR/dotfiles/config"
  '';

  # environment.etc = {
  #   "tmux.conf" = {
  #     source = <dotfig/multiplexers/tmux.conf>;
  #   };
  #   "inputrc" = { # or INPUTRC
  #     source = <dotfig/line-editors/inputrc>;
  #   };
  # };

}
