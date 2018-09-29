{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    ario
    vlc
    geeqie
    # zathura
    # picard

    # keepassx2

    # arandr
    gparted

    # slack
    # libreoffice

  ];
}
