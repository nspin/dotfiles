BS_CFGDIR="$(dirname $(dirname $(dirname $(readlink -m $0))))"
echo $BS_CFGDIR

export PATH="$PATH:$BS_CFGDIR/dotfiles/bin:$BS_CFGDIR/dotfiles/bin/linux:$BS_CFGDIR/local/bin"
export NIX_PATH="$NIX_PATH:dotfig=$BS_CFGDIR/dotfiles/config"
