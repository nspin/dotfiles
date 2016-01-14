#--------------------
# ALIASES
#--------------------

# general
# alias d='cd'
# alias p='cd ..'
# alias r='cd /'

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

# git
alias ga='git add -A :/'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gm='git submodule update --init'
alias gu='git submodule foreach git pull origin master'

# nix
alias nb='nix-build "<nixpkgs>" -A'

# cabal
alias cr='cabal repl'
alias ci='cabal sandbox init'
alias ca='cabal sandbox add-source'
alias co='cabal install --dependencies-only'
