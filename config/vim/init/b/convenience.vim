command VimConf exe 'FZF! $DOTFILES/config/vim'
command Dot exe 'FZF! $DOTFILES'
command Tod exe 'FZF!' expand('~/todo')
command Nde exe 'FZF!' systemlist("echo $NIX_PATH | sed -rn 's/^.*nixpkgs=([^:]+):.*$/\\1/p'")[0]
