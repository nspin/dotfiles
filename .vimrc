"<>=======================<>
"|| NICK SPINALE'S .vimrc ||
"<>=======================<>

" plugins: easymotion, gundo (,nerdtree)

" ===== SETTINGS =====

set nocompatible

set tabstop=4
set shiftwidth=4
set expandtab

set number " show line numbers
set ruler " always show cursor position
set colorcolumn=80
set laststatus=2 " status line always there

set nowrap
set showmatch " of block delimiter
set backspace=indent,eol,start " allow more deletion in insert mode
set spelllang=en_us
set wildmenu " nifty autocomplete in command mode

" ===== MISC =====

syntax on

let mapleader = " "

let g:EasyMotion_leader_key = '\' " easymotion

" ===== MAPPTINGS =====

inoremap jk <esc>
inoremap kj <esc>

nnoremap <leader>u :GundoToggle<CR> " gundo

nnoremap <leader>r :%s/
nnoremap <leader>s :sh<CR>
nnoremap <leader>i `[v`] " highlight last insert

" highlight block delimiters' content (soon-to-be scripts)

nnoremap <leader>p T(vt)
nnoremap <leader>' T'vt'
nnoremap <leader>" T"vt"
nnoremap <leader>` T`vt`
nnoremap <leader>> T<vt>
nnoremap <leader>] T[vt]
nnoremap <leader>} T{vt}

" lazy movement

nnoremap <leader>h 16h
nnoremap <leader>l 16l
nnoremap <leader>j 8j
nnoremap <leader>k 8k
nnoremap <leader>f LzzLzz
nnoremap <leader>d HzzHzz

" file stuff

nnoremap <leader>\ :q!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>e :e<space>

" window management

nnoremap <leader>g <C-w>
nnoremap <leader>n :split<space>
nnoremap <leader>v :vsplit<space>
nnoremap <leader>b :sview
nnoremap <leader>t :tabnew<space>
nnoremap <leader>c :tabn<CR>
nnoremap <leader>m :tabp<CR>

" toggles

nnoremap <leader>1 :set hlsearch!<CR>
nnoremap <leader>2 :set spell!<CR>
nnoremap <leader>3 :set wrap<CR>:nnoremap j gj<CR>:nnoremap k gk<CR>
nnoremap <leader>4 :set nowrap<CR>:unmap j<CR>:unmap k<CR>

" ===== AESTHETICS =====

" I like feeling like I'm in a metal box when I code

highlight TablineFill ctermbg=DarkGrey ctermfg=Black
highlight TabLine ctermbg=DarkGrey ctermfg=Black
highlight TablineSel ctermbg=DarkGrey ctermfg=Grey
highlight StatusLine ctermbg=DarkGrey ctermfg=Black
highlight StatusLineNC ctermbg=DarkGrey ctermfg=Black
highlight VertSplit ctermbg=DarkGrey ctermfg=DarkGrey
highlight LineNr ctermbg=DarkGrey ctermfg=Black

" ===== ABBREVIATIONS =====

" convenience

iab ww where
iab tt type
iab mm import
iab nn instance
iab ee extends
iab pp implements
iab #d #define
iab #i #include

" errors

iab teh the
iab NIck Nick
iab NIcholas Nicholas
iab SPinale Spinale
