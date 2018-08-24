{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.my.config;

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

      MY_VIM_BUNDLE = "${prefix}vim-bundle/bundle";
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
