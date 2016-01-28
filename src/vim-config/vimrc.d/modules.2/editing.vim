filetype plugin indent on

set tabstop=4                                       " may add autocmd to adapt this to filetype
set shiftwidth=4                                    " consistent with tabstop
set expandtab                                       " may add autocmd to adapt this to filetype
set autoindent

set mouse=                                          " not even once
set noesckeys
set virtualedit=block                               " sometimes convenient
set backspace=indent,eol,start                      " allow more deletion in insert mode
set formatoptions=c,q
set textwidth=80

noremap <space>m "m
noremap <space>h "_
noremap <space>f @q

vnoremap <space>n :norm<space>
vnoremap <space>c :call <sid>tabcomms()<cr>

noremap <space>z :Tabularize<space>/

nnoremap <space>s :%s/
nnoremap <space>$ :%s/\s\+$//e<cr> " removes trailing whitespace globally

nnoremap Y y$

noremap <cr> :

inoremap <bar> <bar><esc>:call <sid>align()<cr>a

" for commenting with tabular
let b:ncomment = '#'
autocmd FileType c,cpp,va,scala let b:ncomment = '//'
autocmd FileType haskell let b:ncomment = '--'
autocmd FileType tex let b:ncomment = '%'
autocmd FileType mail let b:ncomment = '>'
autocmd FileType vim let b:ncomment = '"'

" formats visual area with filetype-specific comments with tablular

function! s:tabcomms()
    if exists(':Tabularize')
        execute "'<,'>Tabularize /".b:ncomment
    endif
endfunction

" aligns <bar> tables as you type in insert mode using tabular
" by Tim Pope, not me

function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction


let g:sexp_filetypes = 'lisp,scheme,racket,clojure,timl'
