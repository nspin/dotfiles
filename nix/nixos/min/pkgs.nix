{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    nix-repl nix-prefetch-scripts patchelf

    binutils coreutils which file
    # mercurial subversion wget rsync zip unzip p7zip
    git

    my-vim tmux fzf

    gcc gnumake
    python3

    rxvt_unicode
    sublime3
    # chromium
    dejavu_fonts

    # rlwrap bind
    xclip
    reptyr
    uttyl fznode

    # htop
    # openssl

    # readme-preview

  ];

}
