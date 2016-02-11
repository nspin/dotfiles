function fzfFiles(){
    file=$(find $1 -type f \
            | sed 's#^'$1'/##g' \
            | grep -v '/\.' \
            | grep -v '^\.' \
            | fzf-tmux)
    if test -z $file; then
        echo nop
    else
        echo $file
        vim $1/$file
    fi
}

function dot() {
    fzfFiles /home/nick/dotfiles
}

function nder(){
    readlink $(readlink $HOME/.nix-defexpr/channels_root)/nixos
}

function nde() {
    fzfFiles $(nder)
}
