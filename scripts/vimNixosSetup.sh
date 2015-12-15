basedir=$HOME/dotfiles/src/vim-config

plugins="ycm"

mkdir -p $basedir/result
for plugin in $plugins; do
    nix-build $basedir/nix -A $plugin -o $basedir/result/$plugin
done
