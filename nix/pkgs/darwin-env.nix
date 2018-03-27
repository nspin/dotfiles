pkgs: with pkgs; [

  gnused
  gnugrep
  findutils
  bashInteractive

  reattach-to-user-namespace

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

  # jre jdk

  python27

  (python3.buildEnv.override {
    extraLibs = with python3Packages; [
      cffi
      requests
      beautifulsoup4
      lxml
      # numpy
      # scipy
      # sympy

      # pygments

      # pillow

      # notebook
      # jupyter_console
      # nbconvert
      # ipykernel
      # ipywidgets
    ];
  })

  cabal2nix
  haskellPackages.cabal-install
  haskellPackages.alex
  haskellPackages.happy
  # haskellPackages.pandoc
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

  # (texlive.combine {
  #   inherit (texlive)
  #     luatex
  #     scheme-small
  #     collection-latexextra
  #     collection-fontsrecommended
  #     fontawesome
  #   ;
  # })

  readme-preview

  nodejs
  # clojure
  # leiningen
  # go
  gcc

  cmake
  # maven

  # nmap
  wget
  # gdb
  # nasm
  # radare2
  mitmproxy
  # qemu

  # (lowPrio ihaskell)

]
