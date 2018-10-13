{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    glib.dev
    gnome3.gsettings_desktop_schemas
    ffmpegthumbnailer

    gptfdisk

    # moka-icon-theme
    # arc-theme
    # theme-vertex

  ];

}
