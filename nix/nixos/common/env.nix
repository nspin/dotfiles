{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.my.config;

  dotfiles = pkgs.dotfiles {
    target = cfg.dotfiles + "/config";
    assocs = {
      ".bash_profile"          = "bash/bash_profile.nixos";
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

    my.config.nixpkgs = mkOption {
      type = types.str;
      default = "/cfg/nixpkgs";
    };

    my.config.dotfiles = mkOption {
      type = types.str;
      default = "/cfg/dotfiles";
    };

    my.config.local = mkOption {
      type = types.str;
      default = "/cfg/local";
    };

    my.config.private = mkOption {
      type = types.str;
      default = "/cfg/private";
    };

  };

  config = {

    nixpkgs.config = import <dotfiles/nix/pkgs/config.nix>;
    nixpkgs.overlays = [
      (import <dotfiles/nix/pkgs/overlay>)
    ];

    nix.nixPath = [
      "nixpkgs=${cfg.nixpkgs}"
      "dotfiles=${cfg.dotfiles}"
      "local=${cfg.local}"
      "private=${cfg.private}"
    ];

    environment.pathsToLink = [
      "/share/vim-bundle"
      "/share/dotfiles"
    ];

    environment.systemPackages = [
      dotfiles
    ] ++ pkgs.vim-plugins.all;

    environment.variables = rec {
      MY_OS = "nixos";
      MY_KERNEL = "linux";

      MY_NIXPKGS = "${cfg.nixpkgs}";
      MY_DOTFILES = "${cfg.dotfiles}";
      MY_LOCAL = "${cfg.local}";
      MY_PRIVATE = "${cfg.private}";

      NIXPKGS_CONFIG = MY_DOTFILES + "/nix/pkgs/config.nix";
      NIXOS_CONFIG = MY_DOTFILES + "/nix/nixos/config.nix";

      PAGER = "less -R";
      EDITOR = "vim";
      VISUAL = "vim";

      FZF_DEFAULT_OPTS = "--reverse";
    };

    environment.extraInit = ''
      export PATH="\
      $MY_PRIVATE/bin:\
      $MY_LOCAL/bin:\
      $(find $MY_DOTFILES/bin/$MY_KERNEL -type d -printf ':%p'):\
      $MY_DOTFILES/bin:\
      $PATH"
    '';

    security.sudo.extraConfig = ''

      Defaults env_keep += "MY_OS"
      Defaults env_keep += "MY_KERNEL"

      Defaults env_keep += "MY_NIXPKGS"
      Defaults env_keep += "MY_DOTFILES"
      Defaults env_keep += "MY_LOCAL"
      Defaults env_keep += "MY_PRIVATE"

      Defaults env_keep += "NIXPKGS_CONFIG"
      Defaults env_keep += "NIXOS_CONFIG"

      Defaults env_keep += "PAGER"
      Defaults env_keep += "EDITOR"
      Defaults env_keep += "VISUAL"

      Defaults env_keep += "FZF_DEFAULT_OPTS"

      Defaults env_keep += "NIX_PATH"
      Defaults env_keep += "NIX_PROFILES"

    '';

  };

}
