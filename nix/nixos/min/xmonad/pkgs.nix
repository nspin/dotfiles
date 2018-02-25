{ pkgs, lib, ... }: {

  environment.systemPackages = with pkgs; [

    haskellPackages.xmobar
    scrot
    urxvtdo
    fznode

  ];

}
