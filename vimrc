"<>=======================<>
"|| NICK SPINALE'S .vimrc ||
"<>=======================<>

"TODO
"   fix my indenting functions
"   pathogen dependancy?
"   clear autocmds before any here? (au!)?
"   deal with ftplugins messing with my options (namely fo)
"   syntax on or enable

" ===== VUNDLE STUFF =====

set nocompatible

if has('win32') || has('win16')                             " os specific settings
    set runtimepath+=$HOME/dotfiles/vim/bundle/Vundle.vim
    set runtimepath+=$HOME/dotfiles/vim
else
    set runtimepath+=$HOME/.vim/bundle/Vundle.vim
endif

filetype off                                     " required by vundle
call vundle#begin()                              " required by vundle

Plugin 'gmarik/Vundle.vim'                       " vundle has to manage vundle

Plugin 'sjl/gundo.vim'
Plugin 'SirVer/ultisnips'
Plugin 'godlygeek/tabular'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'gerw/vim-latex-suite'
Plugin 'gerw/vim-tex-syntax'

" --- disabled plugins ---

" Plugin 'msanders/snipmate.vim'
" Plugin 'flazz/vim-colorschemes'
" Plugin 'xolox/vim-colorscheme-switcher'
" Plugin 'bling/vim-airline'
" Plugin 'nanotech/jellybeans.vim'
" Plugin 'twilight'

call vundle#end()                                " required by vundle
filetype plugin on                               " required by vundle

" ===== OPTIONS =====

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
set statusline+=%m%r%h%w%q                       " flags
set statusline+=\ %F\ \ [%v\ %l\ %L]               " file and position
set statusline+=\ [\ %{v:register}\ ]            " current register
set statusline+=\ \ %{strftime(\"%m/%d\ %H:%M\")}  " date+time

" ===== AESTHETICS  =====

set background=dark

if has('win32') || has('win16')          " os specific colorscheme options
    colorscheme nicebox
else
    let g:solarized_termcolors = 256
    colorscheme solarized
endif

syntax on

" ===== MISC =====

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" aligns <bar> tables in insert mode using tabular
" by tim pope, not me

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

" ===== MAPPTINGS =====

let mapleader = " "

" --- some aggressive stuff ---

noremap \ :

inoremap j <esc>
inoremap \\ \
inoremap \j j

" --- lame movement ---

noremap <leader>j 8j
noremap <leader>k 8k
noremap <leader>h 16h
noremap <leader>l 16l

" --- misc ---

nnoremap <leader>s :%s/

" replace expand pre-existing tabs

nnoremap <leader>f4 :%s/\t/    /g<cr>
nnoremap <leader>f8 :%s/\t/        /g<cr>

" remove trailing whitespace

nnoremap <leader>x :%s/\s\+$//e<cr>

" highlight last insert

nnoremap <leader>I `[v`]

" visual mode

vnoremap <leader>z y/<c-r>"<cr>
vnoremap <leader>s y:%s/
vnoremap <leader>a :norm<space>

" --- file stuff ---

nnoremap <leader>Q :quit!<cr>
nnoremap <leader>q :quit<cr>
nnoremap <leader>w :write<cr>
nnoremap <leader>e :edit<space>
nnoremap <leader>r :edit -R<space>
nnoremap <leader>b :shell<cr>

" --- window management ---

nnoremap <leader>n :belowright split<space>
nnoremap <leader>m :belowright vsplit<space>
nnoremap <leader>t :tabnew <space>

" --- for plugins ---

nnoremap <leader>u :GundoToggle<cr>

" formats tables as bars are typed. mostly to convince non-vimmers to use vim

inoremap <bar> <bar><esc>:call <sid>align()<cr>a

" --- toggles ---

nnoremap ,h :set hlsearch!<cr>
nnoremap ,s :setlocal spell!<cr>
nnoremap ,w :setlocal wrap!<cr>
nnoremap ,r :setlocal readonly!<cr>
nnoremap ,d :set digraph<cr>
nnoremap ,l :set wrap<cr>:set nolist<cr>:set linebreak<cr>
nnoremap ,L :set nowrap<cr>:set list<cr>:set nolinebreak<cr>
nnoremap ,g :noremap j gj<cr>:noremap k gk<cr>
nnoremap ,G :unmap j<cr>:unmap k<cr>
nnoremap ,v :set virtualedit=block<cr>
nnoremap ,V :set virtualedit=all<cr>
nnoremap ,c :set colorcolumn!<cr>

" ===== ABBREVIATIONS =====

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
