syntax enable                        " don't override my colors

set background=dark                  " for correct defaults

set nowrap                                          " say no to line wrapping
set showmatch                                       " of block delimiter
set incsearch                                       " sometimes nice
set nohlsearch

" terminal-dependant aesthetic stuff
" setting t_Co is necessary in tmux over ssh, and I have no idea why.
" (still ironing this out)

if exists('$DISPLAY') || system("uname -s") == "Darwin\n"
    colorscheme solarized
elseif $SSH_CONNECTION
    set t_Co=16
    colorscheme solarized
endif

set relativenumber                                  " show rel numbers
set number                                          " show line numbers

set statusline=                                     " clear it
set statusline+=[%v\ %l\ %L]                        " position
set statusline+=\                                   " space
set statusline+=%m%r%h%w%q                          " flags
set statusline+=%=                                  " space
set statusline+=%F                                  " file name

set laststatus=2                                    " status line always there
set showtabline=2                                   " tab line always there

let g:netrw_liststyle = 3
