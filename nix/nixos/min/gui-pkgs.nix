{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    rxvt_unicode
    sublime3
    dejavu_fonts

    xclip

    my-vim

    # chromium

  ];

}
