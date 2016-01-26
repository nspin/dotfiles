set runtimepath+=$HOME/.vim/bundle/Vundle.vim " add vundle to rtp

filetype off                                  " required by vundle
call vundle#begin()                           " required by vundle

Plugin 'VundleVim/Vundle.vim'                    " vundle has to manage vundle

" editing
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'godlygeek/tabular'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" tools
Plugin 'tpope/vim-vinegar'
Plugin 'sjl/gundo.vim'

" integration
Plugin 'jpalardy/vim-slime'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/cscope_macros.vim'

" colors
Plugin 'nickspinale/vim-colors-solarized'
" Plugin 'altercation/vim-colors-solarized'

" stuff I don't want to forget about
" Plugin 'tpope/vim-unimpaired'
" Plugin 'tpope/vim-fugitive'
" Plugin 'majutsushi/tagbar'
" Plugin 'luochen1990/rainbow'
" Plugin 'kien/rainbow_parentheses.vim'

" snipmate and dependencies
" Plugin 'garbas/vim-snipmate'
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'

" Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'

call vundle#end()                                " required by vundle
filetype plugin on                               " required by vundle

