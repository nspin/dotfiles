command VimConf exe 'FZF! $MY_DOTFILES/config/vim'
command Dot exe 'FZF! $MY_DOTFILES'
command Tod exe 'FZF!' expand('~/todo')
command Nde exe 'FZF!' systemlist("echo $NIX_PATH | sed -rn 's/^.*nixpkgs=([^:]+):.*$/\\1/p'")[0]
