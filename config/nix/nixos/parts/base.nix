{ pkgs, ... }:

{

  nixpkgs.config = import <dotfig/nix/pkgs/config.nix>;

  networking.hostName = "nixos";
  networking.hostId = "c890f48c";

  # time.timeZone = "America/New_York";
  time.timeZone = "Europe/Budapest";

  users.extraUsers = {
    nick = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "networkmanager" "transmission" ];
    };
    guest = {
      isNormalUser = true;
      uid = 1001;
    };
    other = {
      isNormalUser = true;
      uid = 1002;
      extraGroups = [ "wheel" "networkmanager" "transmission" ];
    };
  };

  security.sudo = {
    wheelNeedsPassword = false;
    extraConfig = ''
      Defaults env_keep += "NIX_PATH"
    '';
  };

  services.openssh = {
    enable = true;
  };

  services.transmission = {
    enable = true;
    settings = {
      # TODO
      download-dir = "/var/lib/transmission/Downloads";
      incomplete-dir = "/var/lib/transmission/Downloads";
      incomplete-dir-enabled = true;
    };
  };

  services.mpd = {
    enable = true;
    musicDirectory = "/music";
  };

  environment.systemPackages = with pkgs; [
    transmission_remote_gtk
    haskellPackages.vimus
    ario
    gmpc
    mpc_cli
  ];

  environment.variables = rec {
    VISUAL = "vim";
    EDITOR = "vim";
    CFGDIR = "/cfg";
    VIM = CFGDIR + "/dotfiles/config/vim";
    VIMRUNTIME = CFGDIR + "/vim-runtime/runtime";
    VIMBUNDLE = CFGDIR + "/vim-bundle/bundle";
  };

  environment.extraInit = ''
    export PATH="$PATH:$CFGDIR/dotfiles/bin:$CFGDIR/dotfiles/bin/linux"
    export NIX_PATH="$NIX_PATH:dotfig=$CFGDIR/dotfiles/config"
  '';

  environment.etc = {
    "tmux.conf" = {
      source = <dotfig/multiplexers/tmux.conf>;
    };
    # "inputrc" = { # or INPUTRC
    #   source = <dotfig/line-editors/inputrc>;
    # };
  };

}
