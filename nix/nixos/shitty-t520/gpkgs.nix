{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    trayer
    stalonetray
    haskellPackages.xmobar

    rxvt_unicode
    scrot

    chromium
    google-chrome
    firefox
    opera
    torbrowser

    vlc
    zathura

    slack
    libreoffice

    readme-preview

    arandr
    geeqie
    keepassx2
    gparted
    picard

  ];
}
