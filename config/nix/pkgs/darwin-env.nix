pkgs: with pkgs; [

  reattach-to-user-namespace

  # nix
  nix-repl nix-prefetch-scripts patchelf

  rlwrap

  coreutils
  gnumake
  which
  zip
  unzip
  rsync
  file

  my-vim
  tmux
  git
  mercurial
  subversion
  fzf

  openssl

  R jre jdk

  (python35.buildEnv.override { extraLibs = with python35Packages; [ requests2 ]; })
  (python27.buildEnv.override { extraLibs = with python27Packages; [ requests2 ]; })

  cabal2nix
  haskellPackages.cabal-install
  (haskellPackages.ghcWithPackages (hp: with hp; [
    random
    bytestring
    stm
    vector
    containers
    mtl
    network
    async
    attoparsec
    unix
    process
  ]))

  readme-preview

  (texlive.combine {
    inherit (texlive)
      scheme-small
      collection-latexextra
      collection-fontsrecommended
      fontawesome
      # pbox
      # csquotes
      # beamerposter
      # type1cm
    ;
  })

]
