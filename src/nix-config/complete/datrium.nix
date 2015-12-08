{ config, pkgs, ... }:

{

  imports =
    [ ../common.nix
      ../vmware.nix
    ];

  services.vmwareGuest.enable = true;

  environment.systemPackages = with pkgs; [

    adobe-reader

  # nix
    nix-repl
    nix-prefetch-scripts

  # misc command line utils
    zip
    unzip
    tree
    fzf

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
    xchat

  # general development
    tmux
    vimHugeX
    git

  # other languages
    gcc
    python
  ];
}
