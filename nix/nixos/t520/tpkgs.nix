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
    R

    python27

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

  ];

}
