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

  nix-prefetch-scripts
  patchelf
  rlwrap

  update-dotfile-links
  (mkDotfilesIn "${lib.nixPathAttrs.dotfiles}/config" {
    ".bash_profile"          = "bash/bash_profile.${if hostPlatform.isDarwin then "darwin" else "linox"}";
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

] ++ lib.optionals hostPlatform.isDarwin [

  reattach-to-user-namespace

] ++ lib.optionals hostPlatform.isLinux [

] ++ vim-plugins-all
