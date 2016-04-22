set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

set mouse=
set noesckeys
set virtualedit=block
set backspace=indent,eol,start
set formatoptions=c,q
set textwidth=80

nnoremap Y y$

noremap <cr> :

noremap <space>m "m
noremap <space>h "_
noremap <space>f @q

vnoremap <space>n :norm<space>

noremap <space>z :Tabularize<space>/

nnoremap <space>s :%s/
nnoremap <space>$ :%s/\s\+$//e<cr> " removes trailing whitespace globally

inoremap <c-d> <esc>:w<cr>

" for commenting with tabular
let b:inline_comment_str = '#'
for [types, str] in [ ['c,cpp,va,scala' , '//']
                  \ , ['haskell'        , '--']
                  \ , ['tex'            , '%' ]
                  \ , ['mail'           , '>' ]
                  \ , ['vim'            , '"' ]
                  \ ]
  exe 'autocmd FileType '.types." let b:inline_comment_str = '".str."'"
endfor

" Formats visual area with filetype-specific comments with tablular
function! s:tabcomms()
    if exists(':Tabularize')
        execute "'<,'>Tabularize /".b:inline_comment_str
    endif
endfunction

" Aligns <bar> tables as you type in insert mode using tabular
" By Tim Pope, not me
function! s:AlignTable()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

inoremap <bar> <bar><esc>:call <sid>AlignTable()<cr>a
