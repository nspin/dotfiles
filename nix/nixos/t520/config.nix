{ pkgs, ... }: {

  nixpkgs.config = import <dotfiles/nix/pkgs/config.nix>;

  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/etc/nixos/configuration.nix"
    "dotfiles=/cfg/dotfiles"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  security.sudo.extraConfig = ''
    Defaults env_keep += "EDITOR"
    Defaults env_keep += "VISUAL"

    Defaults env_keep += "FZF_DEFAULT_OPTS"

    Defaults env_keep += "DOTFILES"
    Defaults env_keep += "VIM_BUNDLE"
    Defaults env_keep += "VIM_PLUGIN_PATH"
    Defaults env_keep += "MY_LOCAL"

    Defaults env_keep += "NIX_PATH"
  '';

  environment.variables = rec {
    EDITOR = "vim";
    VISUAL = "vim";
    BROWSER = "chromium";

    FZF_DEFAULT_OPTS = "--reverse";

    DOTFILES = "/cfg/dotfiles";
    VIM_BUNDLE = "/cfg/vim-bundle/bundle";
    VIM_PLUGIN_PATH = "${pkgs.vimPlugins.youcompleteme}/share/vim-plugins/youcompleteme";
    MY_LOCAL = "/cfg/local";
  };

  environment.extraInit = ''
    export PATH="$PATH:$DOTFILES/bin:$DOTFILES/bin/linux:$MY_LOCAL/bin"
    export XDG_DATA_DIRS="/cfg/local/share:$XDG_DATA_DIRS"
  '';

}
