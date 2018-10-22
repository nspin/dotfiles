pkgs: with pkgs; [

  bashInteractive
  coreutils
  gnused
  gnugrep
  findutils
  which
  file

  my-vim
  tmux
  git
  fzf
  reattach-to-user-namespace

  nix-prefetch-scripts
  patchelf
  rlwrap

  (dotfiles {
    target = "${ncslib.nixPathAt "dotfiles"}/config";
    assocs = {
      ".bash_profile"          = "bash/bash_profile.macos";
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
  })

] ++ vim-plugins.all
