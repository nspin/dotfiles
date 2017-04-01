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

    desktopManager.xterm.enable = false;

    displayManager.sddm.enable = true;
    displayManager.sddm.theme = "absdark";
    displayManager.sddm.package = pkgs.sddm.override {
      themes = [ (pkgs.callPackages ./sddm-themes/absdark.nix {}) ];
    };

  };

}
