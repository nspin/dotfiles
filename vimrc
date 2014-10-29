" +-----------------------+
" | NICK SPINALE'S .vimrc |
" +-----------------------+

" TODO
"   inchighlight
"   pathogen dependancy?
"   clear autocmds before any here? (au!)?
"   deal with ftplugins messing with my options (namely fo)
"   syntax on or enable?

" ############{VUNDLE STUFF}############

set nocompatible

if has('win32')
    set runtimepath+=$HOME/.vim/bundle/Vundle.vim
endif

set runtimepath+=$HOME/.vim/bundle/Vundle.vim

filetype off                                     " required by vundle
call vundle#begin()                              " required by vundle

Plugin 'gmarik/Vundle.vim'                       " vundle has to manage vundle

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

syntax enable

let g:solarized_termcolors = 256
set background=dark
colorscheme solarized

" ====== OPTIONS ======

set verbose=1                                    " tell me stuff

set tabstop=4
set shiftwidth=4
set expandtab

set virtualedit=block                            " sometimes convenient
set backspace=indent,eol,start                   " allow more deletion in insert mode
set formatoptions=""                             " not familiar with all formatting behavior, so disable it all

set nowrap                                       " say no to line wrapping
set number                                       " show line numbers
set colorcolumn=80                               " marker at 80 columns
set showmatch                                    " of block delimiter

set laststatus=2                                 " status line always there
set showtabline=2                                " tab line always there

set tabline=%t
set statusline=""
set statusline+=%m%r%h%w%q                          " flags
set statusline+=\ %F\ \ [%v\ %l\ %L]                " file and position
set statusline+=\ [\ %{v:register}\ ]               " current register
set statusline+=\ \ %{strftime(\"%m/%d\ %H:%M\")}   " date+time

set spelllang=en_us
set wildmenu                                     " nifty autocomplete in command mode

" ====== MISC ======

autocmd FileType * set formatoptions=""

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" for commenting with tabular

let b:ncomment = '# '
autocmd FileType haskell let b:ncomment = '-- '
autocmd FileType c,cpp,va,scala let b:ncomment = '// '
autocmd FileType tex let b:ncomment = '% '
autocmd FileType mail let b:ncomment = '> '
autocmd FileType vim let b:ncomment = '" '

function! s:tabcomms()
    if exists(':Tabularize')
        execute "Tab /".b:ncomment
    endif

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

noremap <space> <nop>
noremap <cr> <nop>
noremap , <nop>
noremap S <nop>

" --- Special ---

noremap <cr> :

inoremap j <esc>
inoremap \j j

inoremap q <c-n>
inoremap \q q

nnoremap S <c-w>
nnoremap SS :vnew<cr>

inoremap Y y$

inoremap <bar> <bar><esc>:call <sid>align()<cr>a

" ====== FAKE LEADER ======

nnoremap <space>U <c-r>
nnoremap <space>s :%s/
nnoremap <space>b :shell<cr>

vnoremap <space>s y:%s/
vnoremap <space>z y/<c-r>"<cr>
vnoremap <space>a :norm<space>

" highlight last insert
nnoremap <space>v `[v`]

" --- Movement ---

noremap <space>j 8j
noremap <space>k 8k
noremap <space>h 16h
noremap <space>l 16l

nnoremap <space>f <c-f>
nnoremap <space>d <c-b>

" --- Buffer Management ---

nnoremap <space>w :write<cr>
nnoremap <space>q :quit<cr>
nnoremap <space>Q :quit!<cr>
nnoremap <space>e :edit<space>
nnoremap <space>E :tabedit<space>
nnoremap <space>r :view<space>

nnoremap <space>p :CtrlP

" --- Formatting ---

noremap <space>aa :Tab<space>/
noremap <space>a= :Tab<space>/=<cr>
noremap <space>as :Tab<space>/\s\s<cr>
noremap <space>ac :call <sid>tabcomms()<cr>

"expand tabs
nnoremap <space>a4 :%s/\t/    /g<cr>
nnoremap <space>a8 :%s/\t/        /g<cr>

" remove trailing whitespace
nnoremap <space>at :%s/\s\+$//e<cr>

" ====== TOGGLES ======

nnoremap ,u :GundoToggle<cr>

nnoremap ,h :set hlsearch!<cr>
nnoremap ,c :set colorcolumn!<cr>
nnoremap ,s :setlocal spell!<cr>
nnoremap ,w :setlocal wrap!<cr>
nnoremap ,r :setlocal readonly!<cr>

nnoremap ,d :set digraph<cr>

nnoremap ,l :set nolist<cr>:set linebreak<cr>
nnoremap ,L :set list<cr>:set nolinebreak<cr>
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