nnoremap <c-p> :FZF!<cr>

command VimConfigFile exe 'FZF! '.g:vim_config_dir
command Dotfile exe 'FZF! '.expand('~/dotfiles')
command NixDefExpr exe 'FZF! '.systemlist('readlink $(readlink ~/.nix-defexpr/channels_root)/nixos')[0]
command RC e $MYVIMRC
