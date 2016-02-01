function confbash() {
    vim $(find ~/dotfiles/src/interpreters/bash | fzf-tmux)
}

function confnix() {
    vim $(find ~/dotfiles/src/nix | fzf-tmux)
}

function nixdefexp() {
    vim $(find $(readlink $(readlink $HOME/.nix-defexpr/channels_root)/nixos) | fzf-tmux)
}
