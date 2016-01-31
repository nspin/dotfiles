source $stdenv/setup

mkdir -p $out/bin
echo '#!/bin/sh' > $out/bin/fzf-tmux
echo "PATH=\$PATH:$tmux/bin:$fzf/bin:$which/bin sh $src" >> $out/bin/fzf-tmux
chmod +x $out/bin/fzf-tmux
