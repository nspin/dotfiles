{ pkgs, ... }: {

  fonts = {
    enableFontDir = true;
    fontconfig.enable = true;
    fonts = [
      pkgs.dejavu_fonts
      pkgs.font-awesome-ttf
    ];
  };

  environment.systemPackages = with pkgs; [
    xclip
    xorg.xkill
    xorg.xwininfo
    xlibs.xmodmap
    xlibs.xmessage
    xlibs.xev
    dejavu_fonts
  ];

  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";
  };

}
