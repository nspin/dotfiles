{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    nix-repl nix-prefetch-scripts patchelf

    coreutils which file
    zip unzip p7zip
    fzf

    my-vim tmux
    git mercurial subversion

    wget

    rlwrap bind

    htop

    pmtools pmutils
    jmtpfs
    usbutils
    sysstat

    # misc

    openssl
    mitmproxy
    readme-preview

    uttyl fznode reptyr

    # lang

    gcc gnumake
    jre jdk
    rEnv

    python27

    (python35.buildEnv.override {
      extraLibs = with python35Packages; [
        requests2
        numpy
        scipy
      ];
    })

    (texlive.combine {
      inherit (texlive)
        scheme-small
        collection-latexextra
        # blkarray
      ;
    })

    cabal2nix
    haskellPackages.cabal-install
    haskellPackages.pandoc
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

  ];

}
