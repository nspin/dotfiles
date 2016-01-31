syntax enable

set background=dark

set nowrap
set showmatch
set incsearch
set nohlsearch

set relativenumber
set number

set statusline=              " clear it
set statusline+=[%v\ %l\ %L] " position
set statusline+=\            " space
set statusline+=%m%r%h%w%q   " flags
set statusline+=%=           " space
set statusline+=%F           " file name

set laststatus=2
set showtabline=2

" terminal-dependant aesthetic stuff
" setting t_Co is necessary in tmux over ssh, and I have no idea why.
" (still ironing this out)

if exists('$DISPLAY') || system("uname -s") == "Darwin\n"
    colorscheme solarized
elseif $SSH_CONNECTION
    set t_Co=16
    colorscheme solarized
endif
