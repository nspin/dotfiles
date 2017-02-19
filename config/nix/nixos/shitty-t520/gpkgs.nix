{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    rxvt_unicode

    chromium
    google-chrome
    firefox
    opera

    vlc
    zathura

    slack
    libreoffice

    readme_preview

  ];
}
