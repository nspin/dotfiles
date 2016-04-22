command VimConf exe 'FZF!' g:my_vim_dir
command Dot exe 'FZF!' expand('~/dotfiles')
command Tod exe 'FZF!' expand('~/todo')
command Nde exe 'FZF!' systemlist('readlink $(readlink ~/.nix-defexpr/channels_root)/nixos')[0]
