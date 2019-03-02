with import <pkgs>;

let

  a = pkgs.mkDotfilesIn "/cfg/dotfiles/config" {
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
  };

  b = pkgs.mkDotfilesIn "/cfg/dotfiles/config" {
    ".foo"          = "xmonad/xmonad.hs";
  };

in

  buildEnv {
    name = "env";
    paths = [
      a
      b
    ];
  }
