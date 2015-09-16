cwd=$(pwd)
for plugin in $HOME/dotfiles/src/vim-config/annoying/*; do
    cd $plugin
    nix-build
done
