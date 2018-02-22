{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    xclip
    dejavu_fonts
    sshfsFuse
    rsync

    nix-repl nix-prefetch-scripts patchelf

    coreutils which file
    zip unzip p7zip
    fzf

    my-vim tmux
    git mercurial subversion

    wget

    rlwrap bind

    htop

    openssl
    readme-preview

    python3

    sublime3
    rxvt_unicode
    chromium
    readme-preview
  ];

}
