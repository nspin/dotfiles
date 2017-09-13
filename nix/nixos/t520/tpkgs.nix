{ pkgs, ... }: {

  programs.adb.enable = true;
  users.extraUsers.nick.extraGroups = ["adbusers"];


  environment.systemPackages = with pkgs; [

    nix-repl nix-prefetch-scripts patchelf

    coreutils which file
    zip unzip p7zip
    fzf

    my-vim tmux screen
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
    # oraclejdk8 oraclejre8
    # (oraclejdk8distro true true)
    # (callPackage <nixpkgs/pkgs/development/tools/build-managers/apache-maven> { jdk = oraclejdk8; } )
    # (callPackage <nixpkgs/pkgs/development/tools/build-managers/gradle> { jdk = oraclejdk8; }).gradle_latest
    # rEnv

    python27

    (python35.buildEnv.override {
      extraLibs = with python35Packages; [
        requests2
        # gevent
        beautifulsoup4
        numpy
        scipy
        matplotlib
        pyqt5
        sympy
        pillow
      ];
    })

    (texlive.combine {
      inherit (texlive)
        scheme-small
        collection-latexextra
        collection-fontsrecommended
        fontawesome
        biblatex
        logreq
        doublestroke
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
      arithmoi
    ]))

  ];

}
