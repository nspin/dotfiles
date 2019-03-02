{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    xclip
    rxvt_unicode
    sublime3
    dejavu_fonts

    uttyl reptyr

  ];

}
