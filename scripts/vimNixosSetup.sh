basedir=$HOME/.nix-vim
nickspkgs=$HOME/dotfiles/src/local-nix

plugins="ycm"
mkdir -p $basedir

for plugin in $plugins; do
    nix-build $nickspkgs -A $plugin -o $basedir/$plugin
done
