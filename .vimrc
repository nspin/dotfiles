" nick's vimrc
" plugins: easymotion, gundo

set nocompatible
set tabstop=4
set softtabstop=4
set shiftwidth=4
set number
set ruler
set showcmd
set wildmenu
set showmatch
set nowrap
set linebreak
set nolist " for linebreak
set expandtab
set colorcolumn=80
set textwidth=0
set wrapmargin=0
set spelllang=en_us

syntax on

let mapleader = " "

inoremap jk <esc>
inoremap kj <esc>

nnoremap <leader>j 16j " Lzz
nnoremap <leader>k 16k " Hzz
nnoremap <leader>h 16h
nnoremap <leader>l 16l
nnoremap <leader>v '[v']
nnoremap <leader>r :%s/

nnoremap <leader>h :set hlsearch!<return>
nnoremap <leader>s :setlocal spell!<return>
nnoremap <leader>t :set wrap<return>:nnoremap j gj<return>:nnoremap k gk<return>
nnoremap <leader>T :set nowrap<return>:unmap j<return>:unmap k<return>

nnoremap <leader>w :w<return>
nnoremap <leader>1 :q!<return>
nnoremap <leader>b :sh<return>
nnoremap <leader>e :e
nnoremap <leader>v :vnew
nnoremap <leader>n :new

nnoremap <leader>g :GundoToggle<return> " gundo

iab #d #define
iab #i #include
iab #m import
iab #e extends
iab teh the
iab NIck Nick
iab NIcholas Nicholas
iab SPinale Spinale
