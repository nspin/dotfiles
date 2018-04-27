{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    nix-repl nix-prefetch-scripts patchelf

    binutils coreutils which file
    # mercurial subversion wget rsync zip unzip p7zip
    git

    tmux fzf

    gcc gnumake
    python3

    # rlwrap bind
    reptyr
    uttyl fznode

    # htop
    # openssl

    # readme-preview

  ];

}
