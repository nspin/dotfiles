# general
alias vf='vim $(fzf)'
alias cabaldef='cabal2nix . > default.nix'
alias cabalsh='cp ~/dotfiles/store/shell.nix .'

# screen
alias sc='screen -dRR'

# tmux
alias tm='tmux'
alias ta='tmux attach'
alias tt='tmux attach -t'
alias tl='tmux ls'

# vim colors inside of putty
alias ptm='TERM=screen-256color-bce tmux -u'
alias pta='TERM=screen-256color-bce tmux attach -u'
alias ptt='TERM=screen-256color-bce tmux attach -u -t'

# nix
alias nb='nix-build "<nixpkgs>" -A'

# cabal
alias cr='cabal repl'
alias ci='cabal sandbox init'
alias ca='cabal sandbox add-source'
alias co='cabal install --dependencies-only'
