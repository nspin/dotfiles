{ pkgs, lib, ... }: {

  imports = [
    ./gui-pkgs.nix
    ./xmonad
  ];

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
