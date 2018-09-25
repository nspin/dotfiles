{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    nix-prefetch-scripts patchelf

    binutils coreutils which file

    git
    # mercurial subversion wget rsync zip unzip p7zip

    my-vim
    tmux fzf

    gnumake
    # python3

    rlwrap
    fznode
    # bind

    # htop
    # openssl

    # readme-preview

  ];

}
