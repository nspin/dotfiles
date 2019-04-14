syntax enable

set background=dark

set nowrap
set showmatch
set incsearch
set nohlsearch

set relativenumber
set number

let s:statusline_left_side = '[%v %l %L]' " position in file
                         \ . ' '
                         \ . '%m%r%h%w%q' " flags

let g:bufferline_echo = 0
au VimEnter * let &statusline = s:statusline_left_side
                            \ . '%='
                            \ . '%{bufferline#refresh_status()}'
                            \ . bufferline#get_status_string()

" set statusline+=%=           " space
" set statusline+=%F           " file name

set laststatus=2
set showtabline=2

" terminal-dependant aesthetic stuff
" setting t_Co is necessary in tmux over ssh (?)

if exists('$DISPLAY') || system("uname -s") == "Darwin\n"
    colorscheme solarized
elseif $SSH_CONNECTION || exists('$MY_IN_CROSTINI')
    set t_Co=16
    colorscheme solarized
endif
