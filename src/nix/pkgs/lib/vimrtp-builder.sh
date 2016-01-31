source $stdenv/setup
mkdir -p $out/share/vim-plugins
echo $plugins
(echo $plugins | sed 's/ /\n/g') > $out/share/vim-plugins/$outName
