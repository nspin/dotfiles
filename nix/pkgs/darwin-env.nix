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

  (python3.buildEnv.override {
    extraLibs = with python3Packages; [
      cffi
      requests
      beautifulsoup4
      lxml
      numpy
      # scipy
      sympy

      pygments

      # matplotlib
      # pyqt5
      # pillow
      # gevent

      notebook
      jupyter_console
      nbconvert
      ipykernel
      ipywidgets
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

  # readme-preview

  (texlive.combine {
    inherit (texlive)
      luatex
      scheme-small
      collection-latexextra
      collection-fontsrecommended
      fontawesome
    ;
  })

  nodejs
  maven


  nmap
  wget
  # vagrant
  go
  gcc
  cmake

  qemu

  (lowPrio ihaskell)
  clojure
  leiningen

]
