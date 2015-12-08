{ config, pkgs, ... }:

{

  imports =
    [ ../common.nix
      ../vmware.nix
    ];

  services.vmwareGuest.enable = true;

  boot.kernel.sysctl = {
    "kernel.core_pattern" = "|/da/ToolsAndLibs/CodingScripts/zipcore.sh %p %r %u %s";
    "kernel.core_pipe_limit" = 64;
  };

  environment.systemPackages = with pkgs; [

    coreutils

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
