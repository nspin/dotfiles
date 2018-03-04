{ pkgs, ... }: {

  nixpkgs.config = import <dotfiles/nix/pkgs/config.nix>;

  nix.nixPath = [
    "nixpkgs=/cfg/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
    "dotfiles=/cfg/dotfiles"
    "local=/cfg/local"
  ];

  environment.variables = rec {
    EDITOR = "vim";
    VISUAL = "vim";
    TERMINAL = "urxvt";
    BROWSER = "chromium";

    FZF_DEFAULT_OPTS = "--reverse";

    MY_SYSTEM = "linux";
    MY_DOTFILES = "/cfg/dotfiles";
    MY_LOCAL = "/cfg/local";
    MY_VIM_BUNDLE = "/cfg/vim-bundle/bundle";
    MY_VIM_PLUGIN_PATH = "${pkgs.vimPlugins.youcompleteme}/share/vim-plugins/youcompleteme";
  };

  environment.extraInit = ''
    export PATH="$MY_DOTFILES/bin/linux:$MY_DOTFILES/bin:$MY_LOCAL/bin:$PATH"
    export XDG_DATA_DIRS="/cfg/local/share:$XDG_DATA_DIRS"
  '';

  security.sudo.extraConfig = ''
    Defaults env_keep += "EDITOR"
    Defaults env_keep += "VISUAL"
    Defaults env_keep += "TERMINAL"

    Defaults env_keep += "FZF_DEFAULT_OPTS"

    Defaults env_keep += "MY_SYSTEM"
    Defaults env_keep += "MY_DOTFILES"
    Defaults env_keep += "MY_LOCAL"
    Defaults env_keep += "MY_VIM_BUNDLE"
    Defaults env_keep += "MY_VIM_PLUGIN_PATH"

    Defaults env_keep += "NIX_PATH"
  '';

}
