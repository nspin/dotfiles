basedir=$HOME/.nix-vim

plugins="ycm fzf-vim"
mkdir -p $basedir

for plugin in $plugins; do
    nix-build "<nixpkgs>" -A local.$plugin -o $basedir/$plugin
done
