source $stdenv/setup
cp $src fzf-tmux
chmod +x fzf-tmux
patch fzf-tmux $patch
patchShebangs fzf-tmux
substituteInPlace fzf-tmux --replace tmux $tmux/bin/tmux
substituteInPlace fzf-tmux --replace fzfbin $fzf/bin/fzf
mkdir -p $out/bin
mv fzf-tmux $out/bin
