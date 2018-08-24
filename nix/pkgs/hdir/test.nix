with import <nixpkgs> {};
let
  hdir = callPackage ./. {};
in
  hdir {
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
  }
