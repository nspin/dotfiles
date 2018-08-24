{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.my.config;

  hdir = pkgs.hdir {
    target = "/cfg/dotfiles/config";
    assocs = {
      ".bash_profile"          = "bash/bash_profile";
      ".bashrc"                = "bash/bashrc";
      ".tmux.conf"             = "multiplexers/tmux.conf";
      ".vimrc"                 = "vim/vimrc";
      ".config/git/config"     = "git/config";
      ".config/git/ignore"     = "git/ignore";
      ".ghci"                  = "interpreters/ghci";
      ".editrc"                = "line-editors/editrc";
      ".haskeline"             = "line-editors/haskeline";
      ".inputrc"               = "line-editors/inputrc";
    };
  };

in {

  options = {

    my.config.local = mkOption {
      type = types.str;
      default = "/cfg/local";
    };

    my.config.dotfiles = mkOption {
      type = types.str;
      default = "/cfg/dotfiles";
    };

    my.config.nixpkgs = mkOption {
      type = types.str;
      default = "/cfg/nixpkgs";
    };

  };

  config = {

    nixpkgs.config = import <dotfiles/nix/pkgs/config.nix>;

    nix.nixPath = [
      "nixpkgs=${cfg.nixpkgs}"
      "dotfiles=${cfg.dotfiles}"
      "local=${cfg.local}"
    ];

    environment.pathsToLink = [
      "/share/vim-bundle"
      "/share/hdir"
    ];

    environment.systemPackages = [ hdir ];

    environment.variables = rec {
      NIXPKGS_CONFIG = MY_DOTFILES + "/nix/pkgs/config.nix";
      NIXOS_CONFIG = MY_LOCAL + "/config.nix";

      PAGER = "less -R";
      EDITOR = "vim";
      VISUAL = "vim";

      FZF_DEFAULT_OPTS = "--reverse";

      MY_SYSTEM = "linux";
      MY_DOTFILES = "${cfg.dotfiles}";
      MY_LOCAL = "${cfg.local}";
    };

    environment.extraInit = ''
      export PATH="$MY_LOCAL/bin:$(find $MY_DOTFILES/bin/linux -type d -printf ":%p"):$MY_DOTFILES/bin:$PATH"
    '';

    security.sudo.extraConfig = ''
      Defaults env_keep += "NIX_PATH"
      Defaults env_keep += "NIXPKGS_CONFIG"
      Defaults env_keep += "NIXOS_CONFIG"

      Defaults env_keep += "PAGER"
      Defaults env_keep += "EDITOR"
      Defaults env_keep += "VISUAL"

      Defaults env_keep += "FZF_DEFAULT_OPTS"

      Defaults env_keep += "MY_SYSTEM"
      Defaults env_keep += "MY_DOTFILES"
      Defaults env_keep += "MY_LOCAL"
    '';

  };

}
