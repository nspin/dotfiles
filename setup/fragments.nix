# nix-env -i vim
# vi /etc/nixos/configuration.nix

{

  security.sudo.wheelNeedsPassword = false;

  users.extraUsers.x = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    vim git
  ];

}

# nixos-rebuild switch
# nix-env -e vim
# mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bkp
# mkdir /cfg
# chown x /cfg
# chgrp users /cfg
# su x
# vi ~/.ssh/config
# git clone $cfg /cfg --recursive
# cd /cfg/dotfiles/setup
# sh setup-nixos.sh
