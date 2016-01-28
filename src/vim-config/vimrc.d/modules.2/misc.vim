set foldmethod=marker

set spelllang=en_us

" autocmd FileType * set formatoptions=""             " ftplugins mess up this option often

command! NixDefExpr exec "FZF " . system('readlink ~/.nix-defexpr/channels_root')
command! RC e $MYVIMRC
