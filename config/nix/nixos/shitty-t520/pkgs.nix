{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    # nix

    nix-repl
    nix-prefetch-scripts
    patchelf

    # lang

    gcc
    gnumake
    jre
    jdk
    R

    (python35.buildEnv.override {
      extraLibs = with python35Packages; [
        requests2
      ];
    })

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

    # tools

    coreutils
    zip
    unzip
    file
    which
    fzf

    my-vim
    tmux
    git
    mercurial
    subversion

    rlwrap
    bind

    # misc

    openssl

    mitmproxy

  ];
}
