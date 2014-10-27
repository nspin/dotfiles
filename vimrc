"<>=======================o >
"|| NICK SPINALE'S .vimrc ||
"<>=======================<>

" plugins: easymotion, gundo (,nerdtree)

" ===== PRELIMINARY STUFF

set nocompatible

" only source stuff that I want you to source.
" using my dotfiles repo, the only stuff I can't approve is the system vimrc
" (probably $VIM/vimrc). Hopefully its maintainers don't suck

"set runtimepath=""
"set runtimepath+=~/.vim
"call pathogen#infect()

" ===== OPTIONS =====

set verbose=1        " tell me stuff

set tabstop=4
set shiftwidth=4
set expandtab

set virtualedit=all              " necessary for my indenting scripts further down
set backspace=indent,eol,start   " allow more deletion in insert mode

set nowrap              " say no to line wrapping
set number              " show line numbers
set colorcolumn=80      " marker at 80 columns
set laststatus=2        " status line always there
set showtabline=2       " tab line always there
set showmatch           " of block delimiter
set wildmenu            " nifty autocomplete in command mode

set spelllang=en_us

set tabline=%t
set statusline=""                    
set statusline+=%m%r%h%w%q                                " flags
set statusline+=\ %F\ [%v\ %l\ %L]                        " file and position
set statusline+=\ %{strftime(\"%m/%d\ %H:%M\")}           " date+time
set statusline+=\ [\ %{v:register}\ ]                     " current register

" ===== PRE-OTHERSTUFF VIMSCRIPT =====

let mapleader = " "

autocmd FileType haskell            let b:ncomment = '-- '
autocmd FileType c,cpp,java,scala   let b:ncomment = '// '
autocmd FileType sh,ruby,python     let b:ncomment = '# '
autocmd FileType conf,fstab         let b:ncomment = '# '
autocmd FileType tex                let b:ncomment = '% '
autocmd FileType mail               let b:ncomment = '> '
autocmd FileType vim                let b:ncomment = '" '


" midline indenting. yay haskell
"   nregex: regex that marks spot to indent
"   nposition: position of addes spaces relative to nregex
"   ncolumn: column to indent to

"function MidlineInd(nregex, nposition, ncolumn)
" this function moves all text [from the first letter on | after the last letter]
"   to after the column provided

" function! NickFunc(arg)
"     let @z = printf("0/%s%sD%s|p", input("regex: "), a:arg ? "\r" : "/e\rl", input("column: "))
"     execute "normal ".@z
"     endfunction

"function! Midindent(default_regex, replace_regex, indent_regex)
    
"    let @z = printf("0/%s%sD%s|p", input("regex: "), a:arg ? "\r" : "/e\rl", input("column: "))
"    execute "normal 0/
"    endfunction

" ===== MAPPTINGS =====

" some ambitious stuff

noremap \ :

inoremap j <esc>
inoremap \\ \
inoremap \j j

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

" commenting chunks of code.

noremap <leader>cc :s/^/<c-r>=escape(b:ncomment,'\/')<cr>/<cr>
noremap <leader>cu :s/^<c-r>=escape(b:ncomment,'\/')<cr>//e<cr>

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

nnoremap ,c :highlight Comment ctermfg=cyan
nnoremap ,C :highlight Comment ctermfg=darkgrey

" for plugins

nnoremap <leader>u :GundoToggle<cr>

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

" ===== COLORING ===== TODO make seperate colorscheme (include comment toggle mapping in this?)

set background=dark         " to get correct defaults

syntax enable               " hopefully the sourced files are not invasive

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

highlight Comment       cterm=NONE  ctermbg=NONE        ctermfg=darkgrey
