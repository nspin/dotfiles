"<>=======================<>
"|| NICK SPINALE'S .vimrc ||
"<>=======================<>

" plugins: easymotion, gundo (,nerdtree)

" todo: find maps worthy of enter, delete, and \
"       rulerformat and statusline
"       avoid loading plugings or ANYTHING by default
"           (to make my vim thing super super portable)
"       all settings: :set all without vimrc

" ===== CLEAN SLATE =====

set all&

" ===== SETTINGS =====

set nocompatible

set tabstop=4
set shiftwidth=4
set expandtab

set verbose=15 " tell me EVERYTHING

set number " show line numbers
set ruler " always show cursor position
set colorcolumn=80
set laststatus=2 " status line always there
set showtabline=2 " tab line always there

set nowrap
set showmatch " of block delimiter
set backspace=indent,eol,start " allow more deletion in insert mode
set spelllang=en_us
set wildmenu " nifty autocomplete in command mode

" ===== MISC =====

let mapleader = " "

" ===== MAPPTINGS =====

" the essentials

inoremap jk <esc>
inoremap kj <esc>

" serious stuff

inoremap 9 (
inoremap ( 9
inoremap 0 )
inoremap ) 0

nnoremap ; :
nnoremap : ;

" misc

inoremap HH <esc>pa

nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>
nnoremap <leader>i `[v`] " highlight last insert
nnoremap <leader>r :%s/
nnoremap <leader>b :shell<CR>

" highlight block delimiters' content (soon-to-be scripts?)

nnoremap <leader>p T(vt)
nnoremap <leader>' T'vt'
nnoremap <leader>" T"vt"
nnoremap <leader>` T`vt`
nnoremap <leader>> T<vt>
nnoremap <leader>] T[vt]
nnoremap <leader>} T{vt}

" lazy movement

noremap <leader>h 16h
noremap <leader>l 16l
noremap <leader>j 8j
noremap <leader>k 8k
noremap <leader>f Lztzz
noremap <leader>d Hzbzz

" file stuff

nnoremap <leader>q :quit<CR>
nnoremap <leader>\ :quit!<CR>
nnoremap <leader>w :write<CR>
nnoremap <leader>e :edit<space>

" window management

nnoremap <leader>g <C-w>
nnoremap <leader>n :split<space>
nnoremap <leader>m :vsplit<space>
nnoremap <leader>N :sview<space>
nnoremap <leader>M :vertical sview<space>
nnoremap <leader>t :tabnew<space>

" toggles

nnoremap <leader>1 :set hlsearch!<CR>
nnoremap <leader>2 :setlocal spell!<CR>
nnoremap <leader>3 :setlocal wrap!<CR>
nnoremap <leader>4 :setlocal readonly!
nnoremap <leader>5 :set digraph
nnoremap <leader>8 :noremap j gj<CR>:noremap k gk<CR>
nnoremap <leader>9 :unmap j<CR>:unmap k<CR>

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

nnoremap <leader>u :GundoToggle<CR>

" ===== AESTHETICS =====

" hardcoded color scheme in progress. I code in a grey box

syntax clear
syntax enable " here, so that later stuff can correct the colorschemes' infringements

highlight clear " let me take care of this

set background=dark " to get correct defaults

highlight Normal        cterm=NONE      ctermbg=black       ctermfg=white

" window stuff

highlight StatusLine    cterm=NONE      ctermbg=darkgrey    ctermfg=black
highlight StatusLineNC  cterm=NONE      ctermbg=darkgrey    ctermfg=grey
highlight LineNr        cterm=NONE      ctermbg=black       ctermfg=grey

highlight link VertSplit TabLine TablineFill Title StatusLine
highlight link TablineSel StatusLineNC

" only syntax stuff so far

highlight Comment term=italic cterm=NONE ctermfg=grey ctermbg=NONE gui=NONE guifg=#80a0ff guibg=NONE


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
