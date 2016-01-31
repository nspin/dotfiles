function confbash() {
    vim $(find ~/dotfiles/src/interpreters/bash | fzf)
}

function confnix() {
    vim $(find ~/dotfiles/src/nix-config | fzf)
}
