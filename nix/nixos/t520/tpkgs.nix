{ pkgs, ... }: {

  programs.adb.enable = true;
  users.extraUsers.nick.extraGroups = ["adbusers"];


  environment.systemPackages = with pkgs; [

    nix-prefetch-scripts patchelf

    coreutils which file
    zip unzip p7zip
    fzf

    my-vim tmux screen
    git mercurial subversion

    wget

    rlwrap bind

    htop

    pmtools pmutils
    jmtpfs
    usbutils
    sysstat

    # misc

    openssl

    uttyl fznode reptyr

    # lang

    gcc gnumake
    # jre jdk
    # oraclejdk8 oraclejre8
    # (oraclejdk8distro true true)
    # (callPackage <nixpkgs/pkgs/development/tools/build-managers/apache-maven> { jdk = oraclejdk8; } )
    # (callPackage <nixpkgs/pkgs/development/tools/build-managers/gradle> { jdk = oraclejdk8; }).gradle_latest
    # rEnv

    python2

    python3

    (dotfiles {
      target = "/cfg/dotfiles/config";
      assocs = {
        ".bash_profile"          = "bash/bash_profile";
        ".bashrc"                = "bash/bashrc";
        ".tmux.conf"             = "multiplexers/tmux.conf";
        ".vimrc"                 = "vim/vimrc";
        ".config/git/config"     = "git/config";
        ".config/git/ignore"     = "git/ignore";
        ".ghci"                  = "interpreters/ghci";
        ".editrc"                = "line-editors/editrc";
        ".haskeline"             = "line-editors/haskeline";
        ".inputrc"               = "line-editors/inputrc";
      };
    })

  ] ++ vim-plugins.all;

}
