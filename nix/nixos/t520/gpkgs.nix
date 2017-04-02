{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    rxvt_unicode
    chromium
    google-chrome
    firefox
    opera
    torbrowser

    vlc
    zathura

    readme-preview
    arandr
    geeqie
    keepassx2
    gparted
    picard

    slack
    libreoffice

  ];
}
