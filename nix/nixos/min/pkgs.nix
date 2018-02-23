{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    nix-repl nix-prefetch-scripts patchelf

    git mercurial subversion wget
    coreutils which file zip unzip p7zip
    rsync

    my-vim tmux fzf

    gcc gnumake
    python3

    rlwrap bind

    htop

    openssl

    xclip
    dejavu_fonts
    rxvt_unicode
    sublime3
    chromium

    readme-preview

  ];

}
