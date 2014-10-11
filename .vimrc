" nick's vimrc
" plugins: easymotion, gundo

set nocompatible
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set number
set ruler
set showcmd
set wildmenu
set showmatch
set nolist " for linebreak
set linebreak
set textwidth=0
set wrapmargin=0
set spelllang=en_us

syntax on

let mapleader = " "

inoremap jk <esc>
inoremap kj <esc>
inoremap <C-s> <esc>:w<return>i

nnoremap <leader>j Lzz
nnoremap <leader>k Hzz
nnoremap <leader>v '[v']
nnoremap <leader>w :w<return>
nnoremap <leader>z ZZ
nnoremap <leader>! :q!<return>
nnoremap <leader>:%s/
nnoremap <leader>h :set hlsearch!<return>
nnoremap <leader>s :setlocal spell!<return>
nnoremap <leader>r :set wrap<return>:nnoremap j gj<return>:nnoremap k gk<return>
nnoremap <leader>R :set nowrap<return>:unmap j<return>:unmap k<return>
nnoremap <leader>g :GundoToggle<return> " gundo

iab teh the
iab NIck Nick
iab NIcholas Nicholas
iab SPinale Spinale
iab #d #define
iab #i #include
iab #m import
iab #e extends
