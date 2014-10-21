" Nick Spinale's .vimrc
" Plugins: easymotion, gundo (,nerdtree)


set nocompatible

set tabstop=4
set shiftwidth=4
set expandtab

set number
set ruler
set colorcolumn=80
set showmatch

set nowrap
set linebreak " no eol on wrap
set nolist " for linebreak

set wildmenu " better autocomplete in command mode

set spelllang=en_us


syntax on


let mapleader = " "

let g:EasyMotion_leader_key = '\' " easymotion


inoremap jk <esc>
inoremap kj <esc>

nnoremap <leader>i '[v'] " highlight last insert
nnoremap <leader>r :%s/

nnoremap <leader>j 8j
nnoremap <leader>k 8k
nnoremap <leader><leader>j 16j
nnoremap <leader><leader>k 16k
nnoremap <leader>h 16h
nnoremap <leader>l 16l
nnoremap <leader><leader>h 32j
nnoremap <leader><leader>l 32k

nnoremap <leader>8 :set hlsearch!<CR>
nnoremap <leader>9 :set spell!<CR>
nnoremap <leader>0 :set wrap<CR>:nnoremap j gj<CR>:nnoremap k gk<CR>
nnoremap <leader>) :set nowrap<CR>:unmap j<CR>:unmap k<CR>

nnoremap <leader>s :sh<CR>

nnoremap <leader>q ZZ
nnoremap <leader>w :w<CR>
nnoremap <leader>e :e 
nnoremap <leader>1 :q!<CR>

nnoremap <leader>v :sview 
nnoremap <leader>n :split 
nnoremap <leader>m :vplit 
nnoremap <leader>c :tabnew 
nnoremap <leader>x :tabn<CR> 
nnoremap <leader>z :tabp<CR> 

nnoremap <leader>g :GundoToggle<CR> " gundo


iab `d #define
iab `i #include
iab `m import
iab `e extends
iab teh the
iab NIck Nick
iab NIcholas Nicholas
iab SPinale Spinale
