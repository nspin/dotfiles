{ pkgs, lib, ... }: {

  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";
  };
  
  fonts = {
    enableFontDir = true;
    fontconfig.enable = true;
    fonts = [
      pkgs.dejavu_fonts
    ];
  };

}
