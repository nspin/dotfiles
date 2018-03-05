{ pkgs, lib, ... }: {

  imports = [
    ./config.nix
    ./pkgs.nix
    ./xmonad
  ];

  security.sudo.wheelNeedsPassword = false;
  services.openssh.enable = true;
  time.timeZone = "America/Chicago";

  users.extraUsers = {
    nick = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "vboxsf" "docker" ];
    };
  };

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
