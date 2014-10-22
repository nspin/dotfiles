"<>=======================<>
"|| NICK SPINALE'S .vimrc ||
"<>=======================<>

" plugins: easymotion, gundo (,nerdtree)

" ===== SETTINGS =====

set nocompatible

set tabstop=4
set shiftwidth=4
set expandtab

set number
set ruler
set colorcolumn=80
set showmatch " of block delimiter
set nowrap

set spelllang=en_us

set wildmenu " nifty autocomplete in command mode

" ===== MISC =====

syntax on

let mapleader = " "

let g:EasyMotion_leader_key = '\'  " easymotion

" ===== MAPPTINGS =====

inoremap jk <esc>
inoremap kj <esc>

nnoremap <leader>u :GundoToggle<CR>  " gundo

nnoremap <leader>r :%s/
nnoremap <leader>s :sh<CR>
nnoremap <leader>i `[v`]  " highlight last insert

" highlight block delimiters' content (soon-to-be scripts)

nnoremap <leader>p T(vt)
nnoremap <leader>' T'vt'
nnoremap <leader>" T"vt"
nnoremap <leader>` T`vt`
nnoremap <leader>> T<vt>
nnoremap <leader>] T[vt]
nnoremap <leader>] T[vt}

" lazy movement

nnoremap <leader>j 8j
nnoremap <leader>k 8k
nnoremap <leader>h 16h
nnoremap <leader>l 16l

" file stuff

nnoremap <leader><bar> :q!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>e :e<space>

" window management

nnoremap <leader>v :sview
nnoremap <leader>n :split<space>
nnoremap <leader>m :vplit<space>
nnoremap <leader>c :tabnew<space>
nnoremap <leader>x :tabn<CR>
nnoremap <leader>z :tabp<CR>

" toggles

nnoremap <leader>8 :set hlsearch!<CR>
nnoremap <leader>9 :set spell!<CR>
nnoremap <leader>0 :set wrap<CR>:nnoremap j gj<CR>:nnoremap k gk<CR>
nnoremap <leader>00 :set nowrap<CR>:unmap j<CR>:unmap k<CR>

" ===== ABBREVIATIONS =====

" convenience

iab ww where<space>
iab tt type<space>
iab mm import<space>
iab nn instance<space>
iab ee extends<space>
iab pp implements<space>
iab #d #define<space><
iab #i #include<space><

" errors

iab teh the
iab NIck Nick
iab NIcholas Nicholas
iab SPinale Spinale
