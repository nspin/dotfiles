if system('uname -a') =~ 'NixOS'
    source $HOME/.vim-nix-rtp
    for plugin in g:pluginList
        exec 'set rtp+=' . plugin
    endfor
else
    exec 'source ' . g:vimrcDir . 'plugins/vundle.vim'
endif
