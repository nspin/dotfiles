{ pkgs, ... }: {

  programs.adb.enable = true;
  users.extraUsers.nick.extraGroups = ["adbusers"];

  environment.systemPackages = with pkgs; [

    pmtools pmutils
    jmtpfs
    usbutils
    sysstat

    gcc gnumake
    # jre jdk
    # oraclejdk8 oraclejre8
    # (oraclejdk8distro true true)
    # (callPackage <nixpkgs/pkgs/development/tools/build-managers/apache-maven> { jdk = oraclejdk8; } )
    # (callPackage <nixpkgs/pkgs/development/tools/build-managers/gradle> { jdk = oraclejdk8; }).gradle_latest
    # rEnv

    python2

    python3

  ];

}
