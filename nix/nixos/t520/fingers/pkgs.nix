{ pkgs, lib, ... }: {

  environment.systemPackages = with pkgs; [

    trayer
    stalonetray
    haskellPackages.xmobar
    scrot

    upower
    pmtools
    pmutils
    jmtpfs
    usbutils
    sysstat

  ];
 

};
