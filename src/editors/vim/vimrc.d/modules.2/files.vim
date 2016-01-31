nnoremap <c-p> :FZF<cr>

command VimConfigFile exe 'FZF '.g:vim_config_dir
command Dotfile exe 'FZF '.expand('~/dotfiles')
command NixDefExpr exe 'FZF '.system('readlink ~/.nix-defexpr/channels_root')
command RC e $MYVIMRC
