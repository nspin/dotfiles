source $stdenv/setup
cp --no-preserve=mode $src fzf-tmux

cp --no-preserve=mode $patch fzf-tmux.patch
echo "> fzf=$fzf" >> fzf-tmux.patch
patch fzf-tmux fzf-tmux.patch

patchShebangs fzf-tmux
substituteInPlace fzf-tmux --replace tmux $tmux/bin/tmux

mkdir -p $out/bin
chmod +x fzf-tmux
mv fzf-tmux $out/bin
