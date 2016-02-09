let g:sexp_filetypes = 'elisp,lisp,scheme,racket,clojure,timl'

let g:slime_target = "tmux"

let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

imap <c-l> <tab><c-j>

let g:UltiSnipsEdit = 'vertical'

let g:UltiSnipsSnippetsDir = MyVimFile('vim.1/UltiSnips')

let g:dirvish_relative_paths = 1

nnoremap - :call DirvishHere()<cr>

function DirvishHere()
  if empty(expand('%'))
    Dirvish
  else
    Dirvish %
  endif
endfunction
