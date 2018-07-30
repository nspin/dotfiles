{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.my.config;
  prefix = cfg.prefix;

in {

  options = {

    my.config.prefix = mkOption {
      type = types.str;
      default = "/cfg/";
    };

  };

  config = {

    nixpkgs.config = import <dotfiles/nix/pkgs/config.nix>;

    nix.nixPath = [
      "nixpkgs=${prefix}nixpkgs"
      "dotfiles=${prefix}dotfiles"
      "local=${prefix}local"
    ];

    environment.variables = rec {
      PAGER = "less -R";
      EDITOR = "vim";
      VISUAL = "vim";
      TERMINAL = "urxvt";
      BROWSER = "chromium";

      FZF_DEFAULT_OPTS = "--reverse";

      NIXPKGS_CONFIG = MY_DOTFILES + "/nix/pkgs/config.nix";
      NIXOS_CONFIG = MY_LOCAL + "/config.nix";

      MY_SYSTEM = "linux";
      MY_DOTFILES = "${prefix}dotfiles";
      MY_LOCAL = "${prefix}local";
      MY_VIM_BUNDLE = "${prefix}vim-bundle/bundle";
      MY_VIM_PLUGIN_PATH = "${pkgs.vimPlugins.youcompleteme}/share/vim-plugins/youcompleteme";
    };

    environment.extraInit = ''
      export PATH="$MY_LOCAL/bin:$(find $MY_DOTFILES/bin/linux -type d -printf ":%p"):$MY_DOTFILES/bin:$PATH"
      export XDG_DATA_DIRS="${prefix}local/share:$XDG_DATA_DIRS"
    '';

    security.sudo.extraConfig = ''
      Defaults env_keep += "NIX_PATH"

      Defaults env_keep += "PAGER"
      Defaults env_keep += "EDITOR"
      Defaults env_keep += "VISUAL"
      Defaults env_keep += "TERMINAL"

      Defaults env_keep += "FZF_DEFAULT_OPTS"

      Defaults env_keep += "NIXPKGS_CONFIG"
      Defaults env_keep += "NIXOS_CONFIG"

      Defaults env_keep += "MY_SYSTEM"
      Defaults env_keep += "MY_DOTFILES"
      Defaults env_keep += "MY_LOCAL"
      Defaults env_keep += "MY_VIM_BUNDLE"
      Defaults env_keep += "MY_VIM_PLUGIN_PATH"
    '';

  };

}
