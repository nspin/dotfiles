{ pkgs, ... }: {

  environment.systemPackages = with pkgs; with pkgs.xfce; [

    moka-icon-theme
    arc-theme
    theme-vertex

    pmtools
    pmutils
    jmtpfs
    usbutils
    sysstat

  ];

}
