pkgs: with pkgs; [

  gnused
  gnugrep
  findutils
  bashInteractive

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
  # sublime3

  my-vim
  tmux
  git
  mercurial
  subversion
  fzf

  openssl

  jre jdk

  (python35.buildEnv.override {
    extraLibs = with python35Packages; [
      cffi
      requests
      beautifulsoup4
      lxml
      numpy
      # scipy
      sympy

      # matplotlib
      # pyqt5
      # pillow
      # gevent
    ];
  })

  python27

  cabal2nix
  haskellPackages.cabal-install
  haskellPackages.alex
  haskellPackages.happy
  haskellPackages.pandoc
  (haskellPackages.ghcWithPackages (hp: with hp; [
    # random
    bytestring
    # stm
    # vector
    # containers
    # mtl
    # network
    # async
    # attoparsec
    # unix
    # process
  ]))

  readme-preview

  # (texlive.combine {
  #   inherit (texlive)
  #     scheme-small
  #     collection-latexextra
  #     collection-fontsrecommended
  #     fontawesome
  #     pbox
  #     csquotes
  #     beamerposter
  #     type1cm
  #   ;
  # })

  nodejs
  maven
]
