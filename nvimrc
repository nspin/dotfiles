"<>=======================<>
"|| NICK SPINALE'S .vimrc ||
"<>=======================<>

" plugins: easymotion, gundo (,nerdtree)

" todo: find maps worthy of enter, delete, and \
"       rulerformat and statusline
"       avoid loading plugings or ANYTHING by default
"       does mapping to <c- commands make them safe?
"       new :q! binding
"       change where windows appear after <l>n-M

" ===== CLEAN SLATE =====

set all&
syntax clear
highlight clear

" ===== SETTINGS =====

set nocompatible

set verbose=1

set virtualedit=block   " makes visual block mode more convenient
set backspace=indent,eol,start " allow more deletion in insert mode

set tabstop=4
set shiftwidth=4
set expandtab

set spelllang=en_us

set splitbelow          " where will new windows appear
set splitright
set statusline=%t%m | %c - %l | %L | %r%h%w%Y%q
set tabline=%t

set nowrap
set number              " show line numbers
set ruler               " always show cursor position
set colorcolumn=80
set laststatus=2        " status line always there
set showtabline=2       " tab line always there
set showmatch           " of block delimiter
set wildmenu            " nifty autocomplete in command mode

" ===== MISC =====

filetype on             " necessary?

let mapleader = " "

" ===== MAPPTINGS =====

" the essentials

inoremap jk <esc>
inoremap kj <esc>

" serious stuff

noremap \ :

inoremap 9 (
inoremap ( 9
inoremap 0 )
inoremap ) 0

nnoremap <space>v <c-v> " ctrl-q?

" misc

vnoremap <leader>z y/<c-r>"<cr>
vnoremap <leader>s y:%s/
vnoremap <leader>a :norm 

nnoremap <leader>s :%s/
nnoremap <leader>b :shell<cr>

nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

nnoremap <leader>i `[v`] " last insert

" lazy movement

noremap <leader>h 16h
noremap <leader>l 16l
noremap <leader>j 8j
noremap <leader>k 8k
noremap <leader>f LztM
noremap <leader>d HzbM

" file stuff

nnoremap <leader>Q :quit!<cr>
nnoremap <leader>q :quit<cr>
nnoremap <leader>w :write<cr>
nnoremap <leader>e :edit<space>
nnoremap <leader>r :view<space>

" window management

nnoremap <leader>n :split<space>
nnoremap <leader>m :vsplit<space>
nnoremap <leader>N :sview<space>
nnoremap <leader>M :vertical sview<space>
nnoremap <leader>t :tabnew<space>

" commenting chunks of code.

autocmd FileType haskell            let b:comment_captain = '-- '
autocmd FileType c,cpp,java,scala   let b:comment_captain = '// '
autocmd FileType sh,ruby,python     let b:comment_captain = '# '
autocmd FileType conf,fstab         let b:comment_captain = '# '
autocmd FileType tex                let b:comment_captain = '% '
autocmd FileType mail               let b:comment_captain = '> '
autocmd FileType vim                let b:comment_captain = '" '

noremap <leader>cc :s/^/<c-r>=escape(b:comment_captain,'\/')<cr>/<cr>
noremap <leader>cu :s/^<c-r>=escape(b:comment_captain,'\/')<cr>//e<cr>

" toggles

nnoremap ,h :set hlsearch!<cr>
nnoremap ,s :setlocal spell!<cr>
nnoremap ,w :setlocal wrap!<cr>
nnoremap ,r :setlocal readonly!<cr>
nnoremap ,d :set digraph<cr>
nnoremap ,l :set wrap:set nolist:set linebreak<cr>
nnoremap ,L :set nowrap:set list:set nolinebreak<cr>
nnoremap ,g :noremap j gj<cr>:noremap k gk<cr>
nnoremap ,G :unmap j<cr>:unmap k<cr>
nnoremap ,v :set virtualedit=all<cr>
nnoremap ,V :set virtualedit=block<cr>

" ===== ABBREVIATIONS =====

" laziness

iab ww where
iab tt type
iab mm import
iab nn instance
iab ee extends
iab pp implements
iab #d #define
iab #i #include

" mistakes

iab teh the
iab NIck Nick
iab NIcholas Nicholas
iab SPinale Spinale

" ===== PLUGIN STUFF =====

let g:EasyMotion_leader_key = '\'

nnoremap <leader>u :GundoToggle<cr>

" ===== AESTHETICS =====

set background=dark         " to get correct defaults

syntax enable               " later stuff can correct colorschemes' infringements

set background=dark         " in case some other file changed it

highlight Normal        cterm=NONE  ctermbg=black       ctermfg=white

highlight NonText       cterm=NONE  ctermbg=NONE        ctermfg=darkgrey

highlight LineNr        cterm=NONE  ctermbg=NONE        ctermfg=red

highlight ColorColumn   cterm=NONE  ctermbg=darkred         ctermfg=NONE

highlight StatusLineNC  cterm=NONE  ctermbg=darkgrey    ctermfg=grey
highlight TabLineSel    cterm=NONE  ctermbg=darkgrey    ctermfg=grey

highlight StatusLine    cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight TabLineSel    cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight VertSplit     cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight TabLine       cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight TabLineFill   cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight Title         cterm=NONE  ctermbg=darkgrey    ctermfg=black


"=============================================================================
"IGNORE - WILL SOMEDAY MORE FULLY DEFINE A HARD-CODED, SUPER PORTABLE COLOR
"         SCHEME SYSTEM, AND EVENTUALLY ENTIRE PLUGIN SYSTEM, THAT CAN BE
"         TRANSPORTED IN SMALL NUMBER OF FILES, AND OPERATE WITHOUT ANY
"         RUNTIME FILES
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

" for defaults of the highlight option

"ColorColumn Conceal Cursor CursorIM CursorColumn
"CursorLine Directory DiffAdd DiffChange DiffDelete
"DiffText ErrorMsg VertSplit Folded FoldColumn
"SignColumn IncSearch LineNr MatchParen ModeMsg
"MoreMsg NonText Normal Pmenu PmenuSel
"PmenuSbar PmenuThumb Question Search SpecialKey
"SpellBad SpellCap SpellLocal SpellRare StatusLine
"StatusLineNC TabLine TabLineFill TabLineSel Title
"Visual VisualNOS WarningMsg WildMenu 

" same, but just for gui

"Menu Scrollbar Tooltip

" for syntax files. hopefully they aren't doing anything but linking

"highlight Constant term=underline cterm=NONE ctermfg=Magenta ctermbg=NONE gui=NONE guifg=#ffa0a0 guibg=NONE
"highlight Special term=bold cterm=NONE ctermfg=LightRed ctermbg=NONE gui=NONE guifg=Orange guibg=NONE
"highlight Identifier term=underline cterm=bold ctermfg=Cyan ctermbg=NONE gui=NONE guifg=#40ffff guibg=NONE
"highlight Statement term=bold cterm=NONE ctermfg=Yellow ctermbg=NONE gui=bold guifg=#ffff60 guibg=NONE
"highlight PreProc term=underline cterm=NONE ctermfg=LightBlue ctermbg=NONE gui=NONE guifg=#ff80ff guibg=NONE
"highlight Type  term=underline cterm=NONE ctermfg=LightGreen ctermbg=NONE gui=bold guifg=#60ff60 guibg=NONE
"highlight Underlined term=underline cterm=underline ctermfg=LightBlue gui=underline guifg=#80a0ff
"highlight Ignore term=NONE cterm=NONE ctermfg=black ctermbg=NONE gui=NONE guifg=bg guibg=NONE
"highlight Error  term=reverse cterm=NONE ctermfg=White ctermbg=Red gui=NONE guifg=White guibg=Red
"highlight Todo  term=standout cterm=NONE ctermfg=Black ctermbg=Yellow gui=NONE guifg=Blue guibg=Yellow

"=============================================================================
