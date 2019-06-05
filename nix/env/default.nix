pkgs: with pkgs; [

  my-vim tmux git fzf
  file rlwrap
  fznode

  curl wget
  diffutils
  gawk gnupatch gnutar xz less procps

  bashInteractive

  coreutils findutils
  gnused gnugrep
  which file

  gdb screen
  gnumake
  mercurial subversion
  zip unzip p7zip
  rsync

  openssl telnet
  gnupg

  cacert

  readme-preview
  ripgrep jq

  reattach-to-user-namespace

  nix-prefetch-scripts
  patchelf
  rlwrap

  update-dotfile-links
  (mkDotfilesIn "${lib.nixPathAttrs.dotfiles}/config" {
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
  })

] ++ vim-plugins-all
