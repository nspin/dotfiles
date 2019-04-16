{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.my.env;

  dotfiles = pkgs.mkDotfilesIn "${cfg.paths.dotfiles}/config" {
    ".bash_profile"          = "bash/bash_profile.nixos";
    ".bashrc"                = "bash/bashrc";
    ".tmux.conf"             = "multiplexers/tmux.conf";
    ".screenrc"              = "multiplexers/screenrc";
    ".vimrc"                 = "vim/vimrc";
    ".config/git/config"     = "git/config";
    ".config/git/ignore"     = "git/ignore";
    ".ghci"                  = "interpreters/ghci";
    ".editrc"                = "line-editors/editrc";
    ".haskeline"             = "line-editors/haskeline";
    ".inputrc"               = "line-editors/inputrc";
    ".xmonad/xmonad.hs"      = "xmonad/xmonad.hs";
    ".xmobarrc"              = "xmobar/xmobarrc.vm";
  };

in {

  imports = [
    ./pkgs.nix
  ];

  options = {

    my.env.paths.nixpkgs = mkOption {
      type = types.str;
      default = "/cfg/nixpkgs";
    };

    my.env.paths.dotfiles = mkOption {
      type = types.str;
      default = "/cfg/dotfiles";
    };

    my.env.paths.local = mkOption {
      type = types.str;
      default = "/cfg/local";
    };

    my.env.paths.private = mkOption {
      type = types.str;
      default = "/cfg/private";
    };

    my.env.excludedVimPlugins = mkOption {
      type = types.listOf types.str;
      default = [];
    };

  };

  config = {

    nix.nixPath = [
      "nixpkgs=${cfg.paths.nixpkgs}"

      "top=${cfg.paths.dotfiles}/nix"
      "pkgs=${cfg.paths.dotfiles}/nix/path/paths.nix"
      "nixos=${cfg.paths.dotfiles}/nix/path/nixos.nix"
      "nixos-pkgs=${cfg.paths.dotfiles}/nix/path/nixos-pkgs.nix"

      "dotfiles=${cfg.paths.dotfiles}"
      "local=${cfg.paths.local}"
      "private=${cfg.paths.private}"
    ];

    environment.pathsToLink = [
      "/share/vim-bundle"
      "/share/dotfiles"
      "/share/dotfiles/.xmonad"
      "/share/dotfiles/.config"
      "/share/dotfiles/.config/git"
    ];

    environment.systemPackages = [
      dotfiles
      pkgs.update-dotfile-links
    ] ++ pkgs.vim-plugins-excluding cfg.excludedVimPlugins;

    environment.variables = rec {
      MY_OS = "nixos";
      MY_KERNEL = "linux";

      MY_NIXPKGS = cfg.paths.nixpkgs;
      MY_DOTFILES = cfg.paths.dotfiles;
      MY_LOCAL = cfg.paths.local;
      MY_PRIVATE = cfg.paths.private;

      PAGER = "less -R";
      EDITOR = "vim";
      VISUAL = "vim";

      FZF_DEFAULT_OPTS = "--reverse";
    };

    environment.extraInit = ''
      export PATH="${lib.concatStrings [
        "${cfg.paths.private}/bin:"
        "${cfg.paths.local}/bin:"
        "$(find ${cfg.paths.dotfiles}/bin/linux -type d -printf '%p:')"
        "${cfg.paths.dotfiles}/bin:"
        "$PATH"
      ]}"
    '';

    security.sudo.extraConfig = lib.concatMapStrings (var: ''
      Defaults env_keep += "${var}"
    '') [
      "MY_OS" "MY_KERNEL"
      "MY_NIXPKGS" "MY_DOTFILES" "MY_LOCAL" "MY_PRIVATE"
      "PAGER" "EDITOR" "VISUAL"
      "FZF_DEFAULT_OPTS"
      "NIX_PATH"
      "NIX_PROFILES"
    ];

  };

}
