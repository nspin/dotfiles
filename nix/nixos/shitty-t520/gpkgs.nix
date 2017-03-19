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

    vlc
    zathura

    slack
    libreoffice

    readme-preview

  ];
}
