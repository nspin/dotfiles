source $stdenv/setup

mkdir -p $out/bin
echo '#!/bin/sh' > $out/bin/fzf-tmux
echo -n 'PATH=$PATH:' >> $out/bin/fzf-tmux
echo "$tmux/bin:$fzf/bin:$coreutils/bin" >> $out/bin/fzf-tmux
echo "which fzf" >> $out/bin/fzf-tmux
echo "sh $src" >> $out/bin/fzf-tmux
ls $fzf/bin
chmod +x $out/bin/fzf-tmux
