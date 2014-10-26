"<>=======================o >
"|| NICK SPINALE'S .vimrc ||
"<>=======================<>

" plugins: easymotion, gundo (,nerdtree)

" ===== SETTINGS =====

set nocompatible

set verbose=1        " talk to me, vim

set tabstop=4
set shiftwidth=4
set expandtab

set virtualedit=all                  " necessary for my indenting scripts further down
set backspace=indent,eol,start       " allow more deletion in insert mode

set tabline=%t
set statusline=""                    
set statusline+=%m%r%h%w%q                                " flags
set statusline+=\ %F\ [%v\ %l\ %L]                        " file and position
set statusline+=\ %{strftime(\"%m/%d\ %H:%M\")}           " date+time
set statusline+=\ [\ %{v:register}\ ]                     " current register

set nowrap              " say no to line wrapping
set number              " show line numbers
set colorcolumn=80      " marker at 80 columns
set laststatus=2        " status line always there
set showtabline=2       " tab line always there
set showmatch           " of block delimiter
set wildmenu            " nifty autocomplete in command mode

set spelllang=en_us

" ===== MISC =====

let mapleader = " "

" ===== MAPPTINGS =====

" to start...

inoremap jk <esc>
inoremap kj <esc>
noremap \ :

" misc

vnoremap <leader>z y/<c-r>"<cr>
vnoremap <leader>s y:%s/
vnoremap <leader>a :norm<space> 

nnoremap <leader>1t :%s/\t/<tab>/g
nnoremap <leader>2t :%s/\t/<tab><tab>/g
nnoremap <leader>x :%s/\s\+$//e
nnoremap <leader>s :%s/
nnoremap <leader>b :sh<cr>
nnoremap <leader>o :let<space>

nnoremap <leader>I `[v`] " hl last insert

" lazy movement (may drop)

noremap <leader>h 16h
noremap <leader>l 16l
noremap <leader>j 8j
noremap <leader>k 8k
noremap <leader>f LztM
noremap <leader>d HzbM

" file stuff

nnoremap <leader>Q :q!<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>e :e<space>
nnoremap <leader>r :e -R<space>

" window management

nnoremap <leader>n :belowright split<space>
nnoremap <leader>m :belowright vsplit<space>
nnoremap <leader>t :tabe <space>

" this function moves all text [from the first letter on | after the last letter]
"   to after the column provided

function! NickFunc(arg)
    let @z = printf("0/%s%sD%s|p", input("regex: "), a:arg ? "\r" : "/e\rl", input("column: "))
    execute "normal ".@z
    endfunction

"function! Midindent(default_regex, replace_regex, indent_regex)
    
"    let @z = printf("0/%s%sD%s|p", input("regex: "), a:arg ? "\r" : "/e\rl", input("column: "))
"    execute "normal 0/
"    endfunction

noremap <leader># :call NickFunc(1)<cr>
noremap <leader>ff execute "normal ".

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

nnoremap ,h :se hlsearch!<cr>
nnoremap ,s :setl spell!<cr>
nnoremap ,w :setl wrap!<cr>
nnoremap ,r :setl readonly!<cr>
nnoremap ,d :se digraph<cr>
nnoremap ,l :se wrap:set nolist:set linebreak<cr>
nnoremap ,L :se nowrap:set list:set nolinebreak<cr>
nnoremap ,g :no j gj<cr>:noremap k gk<cr>
nnoremap ,G :unm j<cr>:unmap k<cr>
nnoremap ,v :se virtualedit=block<cr>
nnoremap ,V :se virtualedit=all<cr>

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

" ===== PLUGIN STUFF =====

nnoremap <leader>u :GundoToggle<cr>

" ===== COLORING =====

set background=dark         " to get correct defaults

syntax enable               " later stuff can correct colorschemes' infringements

highlight Normal        cterm=NONE  ctermbg=black       ctermfg=white
highlight NonText       cterm=NONE  ctermbg=NONE        ctermfg=darkgrey
highlight LineNr        cterm=NONE  ctermbg=NONE        ctermfg=red
highlight ColorColumn   cterm=NONE  ctermbg=darkred     ctermfg=NONE

highlight StatusLineNC  cterm=NONE  ctermbg=darkgrey    ctermfg=grey
highlight TabLine       cterm=NONE  ctermbg=darkgrey    ctermfg=grey

highlight Pmenu         cterm=NONE  ctermbg=darkgrey    ctermfg=red
highlight PmenuSel      cterm=NONE  ctermbg=darkgrey    ctermfg=black

highlight StatusLine    cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight TabLineSel    cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight VertSplit     cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight TabLine       cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight TabLineFill   cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight Title         cterm=NONE  ctermbg=darkgrey    ctermfg=black
