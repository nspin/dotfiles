command VimConf exe 'FZF! $DOTFILES/config/vim'
command Dot exe 'FZF! $DOTFILES'
command Tod exe 'FZF!' expand('~/todo')
command Nde exe 'FZF!' systemlist('readlink $(readlink ~/.nix-defexpr/channels)/nixpkgs')[0]
