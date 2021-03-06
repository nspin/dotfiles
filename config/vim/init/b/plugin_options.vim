let loaded_gzip = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_zipPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_netrwPlugin = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_logiPat = 1

let g:sexp_filetypes = 'elisp,lisp,scheme,racket,clojure,timl'

let g:slime_target = "tmux"

let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

imap <c-l> <tab><c-j>

let g:UltiSnipsEdit = 'vertical'
let g:UltiSnipsSnippetsDir = $MY_DOTFILES.'/config/vim/ultisnips'

let g:dirvish_relative_paths = 1

nnoremap - :call DirvishHere()<cr>

fun DirvishHere()
  if empty(expand('%'))
    Dirvish
  else
    Dirvish %
  endif
endfun

let g:NERDTreeHijackNetrw = 0

let g:tex_indent_and = 0
let g:tex_indent_brace = 0
let g:tex_indent_items = 0
let g:tex_indent_parentheses = 0

let g:ycm_server_python_interpreter = trim(system('which python3'))
" let g:ycm_global_ycm_extra_conf = $MY_DOTFILES.'/config/vim/ycm_extra_conf.py'
" HACK only way I've found to silence warnings
" let g:ycm_log_level = 'foo'
let g:ycm_filetype_specific_completion_to_disable = {
  \ 'c': 1,
  \ 'cpp': 1,
  \ }

" let g:linuxsty_patterns = [ '/linux\(+[^/]\+\)?/' ]
let g:linuxsty_patterns = [ '/linux/', '/linux+[^/]\+' ]
