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

nnoremap <leader>j 8j
nnoremap <leader>k 8k
nnoremap <leader><leader>j 16j
nnoremap <leader><leader>k 16k
nnoremap <leader>h 16h
nnoremap <leader>l 16l
nnoremap <leader><leader>h 32j
nnoremap <leader><leader>l 32k
nnoremap <leader>v '[v']
nnoremap <leader>r :%s/

nnoremap <leader>H :set hlsearch!<return>
nnoremap <leader>9 :setlocal spell!<return>
nnoremap <leader>0 :set wrap<return>:nnoremap j gj<return>:nnoremap k gk<return>
nnoremap <leader>) :set nowrap<return>:unmap j<return>:unmap k<return>

nnoremap <leader>w :w<return>
nnoremap <leader>1 :q!<return>
nnoremap <leader>b :sh<return>
nnoremap <leader>e :e 
nnoremap <leader>n :new 
nnoremap <leader>v :vnew 
nnoremap <leader>t :tabnew 
nnoremap <leader>c :tabn<return> 
nnoremap <leader>x :tabp<return> 

nnoremap <leader>g :GundoToggle<return> " gundo

iab #d #define
iab #i #include
iab #m import
iab #e extends
iab teh the
iab NIck Nick
iab NIcholas Nicholas
iab SPinale Spinale
