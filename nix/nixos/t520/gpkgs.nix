{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    atom

    rxvt_unicode

    chromium
    # google-chrome
    # firefox opera
    # torbrowser

    ario
    vlc
    geeqie
    zathura
    # picard

    # readme-preview
    # keepassx2

    # arandr
    gparted

    # slack
    # libreoffice

    # rstudioEnv

  ];
}
