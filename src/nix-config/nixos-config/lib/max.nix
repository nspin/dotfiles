{ config, pkgs, ... }:

with import ../../../local-nix { nixpkgs = pkgs; } ;

{
  environment.systemPackages = with pkgs; [

    mars
    mips-init
    hscript-test

    adobe-reader

  # nix
    nix-repl
    nix-prefetch-scripts

  # misc command line utils
    zip
    unzip
    tree
    fzf
    fzf-tmux

  # random
    rlwrap

  # x tools
    xclip
    xorg.xkill
    xlibs.xmodmap

  # x utils
    dmenu
    gmrun
    xlibs.xmessage
    haskell.packages.ghc7102.xmobar

  # fonts
    dejavu_fonts

  # x applications
    firefox
    # xchat

  # general development
    tmux
    vimHugeX
    git

  # ghc
    haskell.packages.ghc7102.ghc
    haskell.packages.ghc7102.cabal-install
    haskell.packages.ghc7102.cabal2nix
    haskell.packages.ghc7102.hoogle
    haskell.packages.ghc7102.hdevtools
    haskell.packages.ghc7102.hlint

  # ghcjs
    # haskell.packages.ghcjs.ghc

  # java bullshit
    jdk
    maven

  # other languages
    gcc
    clang
    # mitscheme
    # racket
    nodejs
    python27

    # (texLiveAggregationFun { paths = [ texLive texLiveExtra texLiveBeamer lmodern ]; })

  # fonts
    # cm_unicode

  # other
    haskell.packages.ghc7102.pandoc
    libreoffice
  ];
}