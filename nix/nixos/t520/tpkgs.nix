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

  ] ++ vim-plugins.all;

}
