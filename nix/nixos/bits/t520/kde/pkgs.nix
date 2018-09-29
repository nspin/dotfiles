{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    # moka-icon-theme
    # arc-theme
    # theme-vertex

    pmtools
    pmutils
    jmtpfs
    usbutils
    sysstat

  ];

}
