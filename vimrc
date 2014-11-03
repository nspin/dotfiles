" +-----------------------+
" | NICK SPINALE'S .vimrc |
" +-----------------------+

" TODO
"   inchighlight
"   find mappings worthy of ; and <del>
"   clear autocmds before any here? (au!)?
"   deal with ftplugins messing with my options (namely fo)
"   tabular comment function
"       will improve regex to only match last comment phrase in line
"       and not match full-line comments

" ############{VUNDLE STUFF}############

set nocompatible

if has('win32')
    set runtimepath+=$HOME/.vim               " foting other stuff to '~/vimfiles'
endif                                         " this too

set runtimepath+=$HOME/.vim/bundle/Vundle.vim

filetype off                                  " required by vundle
call vundle#begin()                           " required by vundle

Plugin 'gmarik/Vundle.vim'                    " vundle has to manage vundle

Plugin 'sjl/gundo.vim'
Plugin 'SirVer/ultisnips'
Plugin 'godlygeek/tabular'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'gerw/vim-latex-suite'
Plugin 'gerw/vim-tex-syntax'

" Plugin 'msanders/snipmate.vim'
" Plugin 'flazz/vim-colorschemes'
" Plugin 'xolox/vim-colorscheme-switcher'
" Plugin 'bling/vim-airline'
" Plugin 'nanotech/jellybeans.vim'
" Plugin 'twilight'

call vundle#end()                                " required by vundle
filetype plugin on                               " required by vundle

" ############{MISC}############

" ====== AESTHETICS ======

syntax enable                        " don't override my colors

set background=dark                  " for correct defaults

if has('win32')
    colorscheme nicebox              " still haven't gotten any windows terminal's colors to work
else
    let g:solarized_termcolors = 256 " just to be safe
    colorscheme solarized            " what else?
endif

" ====== OPTIONS ======

set verbose=1                                       " tell me stuff

set tabstop=4                                       " may add autocmd to adapt this to filetype
set shiftwidth=4                                    " consistent with tabstop
set expandtab                                       " may add autocmd to adapt this to filetype

set mouse=""                                        " not even once
set virtualedit=block                               " sometimes convenient
set backspace=indent,eol,start                      " allow more deletion in insert mode
set formatoptions=""                                " not familiar with all formatting behavior, so disable it all
    
set nowrap                                          " say no to line wrapping
set number                                          " show line numbers
set colorcolumn=80                                  " marker at 80 columns
set showmatch                                       " of block delimiter
set hlsearch                                        " sometimes nice

set laststatus=2                                    " status line always there
set showtabline=2                                   " tab line always there

set tabline=%t                                      " just title
set statusline=""                                   " clear it
set statusline+=%m%r%h%w%q                          " flags
set statusline+=\ %F\ \ [%v\ %l\ %L]                " file and position
set statusline+=\ [\ %{v:register}\ ]               " current register
set statusline+=\ \ %{strftime(\"%m/%d\ %H:%M\")}   " date+time

set spelllang=en_us" if only vim spellchecked haskell...
set wildmenu                                        " nifty autocomplete in command mode

" ====== MISC ======

autocmd FileType * set formatoptions=""   " ftplugins mess up this option often

" UltiSnips mappings

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" for commenting with tabular

let b:ncomment = '#'
autocmd FileType haskell let b:ncomment = '--'
autocmd FileType c,cpp,va,scala let b:ncomment = '//'
autocmd FileType tex let b:ncomment = '%'
autocmd FileType mail let b:ncomment = '>'
autocmd FileType vim let b:ncomment = '"'

" formats filetype-specific comments with tablular

function! s:tabcomms()
    if exists(':Tabularize')
        execute "'<,'>Tabularize /".b:ncomment
    endif
endfunction

" aligns <bar> tables AS YOU TYPE in insert mode using tabular
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

" ############{MAPPINGS}############

" --- Nop's ---

noremap <cr> <nop>
noremap S <nop>
noremap Y <nop>
noremap <space> <nop>
noremap , <nop>

" --- Special ---

inoremap j <esc>
inoremap JJ j

inoremap q <c-n>
inoremap QQ q

noremap <cr> :

nnoremap S <c-w>
nnoremap SS :vnew<cr>

nnoremap Y y$

inoremap <bar> <bar><esc>:call <sid>align()<cr>a

" ====== FAKE LEADER ======

" movement
nnoremap <space>f <c-f>M
nnoremap <space>d <c-b>M

" buffer management
nnoremap <space>q :quit<cr>
nnoremap <space>Q :quit!<cr>
nnoremap <space>w :write<cr>
nnoremap <space>e :edit<space>
nnoremap <space>r :view<space>
nnoremap <space>t :tabedit<space>

nnoremap <space>p :CtrlP

noremap <space>l :Tabularize<space>/
noremap <space>c :call <sid>tabcomms()<cr>

" remove trailing whitespace
nnoremap <space>x :%s/\s\+$//e<cr>

nnoremap <space>s :%s/
nnoremap <space>b :shell<cr>

" highlight last insert
nnoremap <space>v `[v`]

vnoremap <space>s y:%s/<c-r>"<cr>/
vnoremap <space>a y/<c-r>"<cr>
vnoremap <space>n :norm<space>

" ====== TOGGLES ======

nnoremap ,u :GundoToggle<cr>

nnoremap ,c :setlocal colorcolumn!<cr>
nnoremap ,s :setlocal spell!<cr>
nnoremap ,w :setlocal wrap!<cr>
nnoremap ,r :setlocal readonly!<cr>

nnoremap ,d :set digraph<cr>

nnoremap ,l :setlocal nolist<cr>:setlocal linebreak<cr>
nnoremap ,L :setlocal list<cr>:setlocal nolinebreak<cr>
nnoremap ,v :set virtualedit=all<cr>
nnoremap ,V :set virtualedit=block<cr>
nnoremap ,g :noremap j gj<cr>:noremap k gk<cr>
nnoremap ,G :unmap j<cr>:unmap k<cr>

" ############{ABBREVIATIONS}############

" laziness

iabbrev `w where
iabbrev `t type
iabbrev `m import
iabbrev `n instance
iabbrev `e extends
iabbrev `p implements
iabbrev `d #define
iabbrev `i #include

" mistakes

iabbrev teh the
iabbrev NIck Nick
iabbrev NIcholas Nicholas
iabbrev SPinale Spinale
