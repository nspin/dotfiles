{ pkgs, ... }: {

  imports = [
    # <nixpkgs/nixos/modules/virtualisation/virtualbox-image.nix>
    <dotfiles/nix/nixos/min/config.nix>
    <dotfiles/nix/nixos/min/pkgs.nix>
  ];

  system.nixos.stateVersion = "18.09";

  # virtualbox.baseImageSize = 32 * 1024;

  my.config.nixpkgs = "${pkgs.fetchFromGitHub {
    owner = "nspin";
    repo = "nixpkgs";
    rev = "34f559a6843fd1c1bd3ac611036a0d27b1e5ebff";
    sha256 = "1gv20kddmq4hz28fwyl56gswlhvs6swzj00ifbd14vv15pjnq3rg";
  }}";

  my.config.dotfiles = "${pkgs.fetchFromGitHub {
    owner = "nspin";
    repo = "dotfiles";
    rev = "be7d33e6d4a67ba27b14fa6a6d58c337d7172b5f";
    sha256 = "0kb1l3wmhmzwr7kxl10h6qanq9vh9csxw2smvam7f6y9zaw0sr4n";
  }}";

  networking.firewall.enable = false;
  services.openssh.enable = true;
  security.sudo.wheelNeedsPassword = false;
  users.mutableUsers = false;
  users.extraUsers.x = {
    uid = 1000;
    isNormalUser = true;
    password = "";
    extraGroups = [ "wheel" "docker" "vboxsf" ];
  };

}
