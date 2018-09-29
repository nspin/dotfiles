{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    firefox

    xorg.xkill
    xorg.xwininfo
    xlibs.xmodmap
    xlibs.xmessage
    xlibs.xev

  ];

}
