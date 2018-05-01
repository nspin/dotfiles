{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    nix-repl nix-prefetch-scripts patchelf

    binutils coreutils which file
    # mercurial subversion wget rsync zip unzip p7zip
    git

    my-vim
    tmux fzf

    gcc gnumake
    python3

    # rlwrap bind
    fznode

    # htop
    # openssl

    # readme-preview

  ];

}
