{ pkgs, ... }:

{

  imports = [
    ./modules/core.nix
    ./modules/graphical
  ];

  system.stateVersion = "16.03";

  boot.loader.grub.devices = [ "/dev/sda" ];

  environment.systemPackages = with pkgs; [

    nix-repl
    nix-prefetch-scripts
    patchelf
    
    rlwrap
    
    coreutils
    gnumake
    which
    file

    gcc
    vimHugeX
    
    tmux
    git

    fzf

    xclip
    xorg.xkill
    xlibs.xmodmap
    xlibs.xmessage
    
    chromium
    
    dejavu_fonts

  ];

}
