command VimConf exe 'FZF! $CFGDIR/dotfiles/config/vim'
command Dot exe 'FZF! $CFGDIR/dotfiles'
command Tod exe 'FZF!' expand('~/todo')
command Nde exe 'FZF!' systemlist('readlink $(readlink ~/.nix-defexpr/channels_root)/nixpkgs')[0]
