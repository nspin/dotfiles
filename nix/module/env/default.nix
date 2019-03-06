{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.my.env.paths;

  dotfiles = pkgs.mkDotfilesIn "${cfg.dotfiles}/config" {
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

  };

  config = {

    nix.nixPath = [
      "nixpkgs=${cfg.nixpkgs}"
      "dotfiles=${cfg.dotfiles}"
      "local=${cfg.local}"
      "private=${cfg.private}"
      "nixos-config=${cfg.dotfiles}/nix/module"
      "pkgs=${cfg.dotfiles}/nix/nixos-pkgs.nix"
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
    ] ++ pkgs.vim-plugins-all;

    environment.variables = rec {
      MY_OS = "nixos";
      MY_KERNEL = "linux";

      MY_NIXPKGS = cfg.nixpkgs;
      MY_DOTFILES = cfg.dotfiles;
      MY_LOCAL = cfg.local;
      MY_PRIVATE = cfg.private;

      PAGER = "less -R";
      EDITOR = "vim";
      VISUAL = "vim";

      FZF_DEFAULT_OPTS = "--reverse";
    };

    environment.extraInit = ''
      export PATH="${lib.concatStrings [
        "${cfg.private}/bin:"
        "${cfg.local}/bin:"
        "$(find ${cfg.dotfiles}/bin/linux -type d -printf '%p:')"
        "${cfg.dotfiles}/bin:"
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
