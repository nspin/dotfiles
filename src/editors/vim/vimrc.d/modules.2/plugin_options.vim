let g:sexp_filetypes = 'lisp,scheme,racket,clojure,timl'

let g:slime_target = "tmux"

" let g:loaded_netrw = 1
" let g:loaded_netrwPlugin = 1
" let g:loaded_2html_plugin=1
" let g:loaded_vimballPlugin=1
" let g:loaded_getscriptPlugin=1
" let g:loaded_gzip=1
" let g:loaded_logipat=1
" let g:loaded_rrhelper=1
" let g:loaded_spellfile_plugin=1
" let g:loaded_tarPlugin=1
" let g:loaded_zipPlugin=1

" let g:netrw_liststyle = 3
" let g:netrw_dirhistmax = 0

let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

imap <c-l> <tab><c-j>

let g:UltiSnipsEdit = 'vertical'

let g:UltiSnipsSnippetsDir = g:vim_config_dir.'vim.1/UltiSnips'

let g:dirvish_relative_paths = 1

nnoremap - :Dirvish %<cr>
