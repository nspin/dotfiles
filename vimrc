" this is a | tes |
" the | test contingus |
" | || | \ 
" +-----------------------+
" | NICK SPINALE'S .vimrc |
" +-----------------------+

" TODO
"   <SNR> for | align function?
"   pathogen dependancy?
"   clear autocmds before any here? (au!)?
"   deal with ftplugins messing with my options (namely fo)
"   syntax on or enable?

" ############{VUNDLE STUFF}############

set nocompatible

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
set formatoptions=                               " not familiar with all formatting behavior, so disable it all

set nowrap                                       " say no to line wrapping
set number                                       " show line numbers
set colorcolumn=80                               " marker at 80 columns
set laststatus=2                                 " status line always there
set showtabline=2                                " tab line always there
set showmatch                                    " of block delimiter
set wildmenu                                     " nifty autocomplete in command mode

set spelllang=en_us

set tabline=%t
set statusline=""
set statusline+=%m%r%h%w%q                          " flags
set statusline+=\ %F\ \ [%v\ %l\ %L]                " file and position
set statusline+=\ [\ %{v:register}\ ]               " current register
set statusline+=\ \ %{strftime(\"%m/%d\ %H:%M\")}   " date+time

" ====== MISC ======

let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" ====== FUNCTIONS ======

" aligns <bar> tables AS YOU TYPE in insert mode using tabular
" formats tables as bars are typed. mostly to convince non-vimmers to use vim
" by tim pope, not me

" ############{MAPPINGS}############

" --- Nop's ---

"noremap <space> <nop>
" noremap <cr> <nop>
" noremap , <nop>
" noremap S <nop>

" --- Special ---

noremap <cr> :
noremap S <c-w>

inoremap j <esc>
inoremap \\ \
inoremap \j j

inoremap q <c-n>
inoremap \\ \
inoremap \q q

inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

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

" ====== FAKE LEADER ======

" left leader as <bslash> for plugins

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

noremap <space>t :Tab<space>

nnoremap <space>T4 :%s/\t/    /g<cr>
nnoremap <space>T8 :%s/\t/        /g<cr>

" remove trailing whitespace
nnoremap <space>x :%s/\s\+$//e<cr>

" --- Cetera ---

nnoremap <space>U <c-r>
nnoremap <space>s :%s/
nnoremap <space>b :shell<cr>

vnoremap <space>s y:%s/
vnoremap <space>z y/<c-r>"<cr>
vnoremap <space>a :norm<space>

" highlight last insert
nnoremap <space>I `[v`]

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

iabbrev #w where
iabbrev #t type
iabbrev #m import
iabbrev #n instance
iabbrev #e extends
iabbrev #p implements
iabbrev #d #define
iabbrev #i #include

" mistakes

iabbrev teh the
iabbrev NIck Nick
iabbrev NIcholas Nicholas
iabbrev SPinale Spinale
