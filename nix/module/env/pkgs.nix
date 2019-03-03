{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.my.env.pkgs;

in {

  options = {

    my.env.pkgs.tui = mkOption {
      type = types.int;
      default = 0;
    };

    my.env.pkgs.gui = mkOption {
      type = types.int;
      default = 0;
    };

  };

  config = {

    environment.systemPackages = with pkgs; [

      my-vim tmux git fzf wget 
      file rlwrap
      fznode

    ] ++ optionals (cfg.tui >= 1) [

      gdb screen
      gnumake binutils
      mercurial subversion
      zip unzip p7zip
      python2 python3
      jre jdk

      nix-prefetch-scripts patchelf

      openssl telnet sshfsFuse

      htop
      pmtools pmutils sysstat usbutils hwinfo 
      cryptsetup e2tools e2fsprogs

      readme-preview
      ripgrep jq

    ] ++ optionals (cfg.tui >= 2) [

      jmtpfs

      (texlive.combine {
        inherit (texlive)
          luatex
          scheme-small
          collection-latexextra
          collection-fontsrecommended
          fontawesome
        ;
      })

    ] ++ optionals (cfg.gui >= 1) [

      xclip
      rxvt_unicode
      sublime3
      dejavu_fonts

      uttyl reptyr

      xorg.xkill
      xorg.xwininfo
      xlibs.xmodmap
      xlibs.xmessage
      xlibs.xev
      arandr

      firefox

    ] ++ optionals (cfg.gui >= 2) [

      gparted

      vlc audacity picard ario geeqie gimp 

      slack
      libreoffice

      chromium
      google-chrome
      adobe-reader

      virtualbox

    ];

  };

}
