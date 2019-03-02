{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    binutils
    gnused
    gnugrep
    findutils
    which
    file

    my-vim
    tmux
    git
    fzf
    fznode

    nix-prefetch-scripts
    patchelf
    rlwrap

  ];

}
