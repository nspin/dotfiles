###############################
# NICK SPINALE
# $HOME/.bashrc
###############################

# HACKY WAY TO MAKE COLORS IN SCREEN OK IN X11/OSX
# TODO - make this not suck
# (note: also try $DISPLAY)

if [ -n "$WINDOWID" ]; then
    export TERM="xterm-256color"
fi

if [ "$(uname)" == "Darwin" ]; then
    export TERM="xterm-256color"
fi

#--------------------
# COMMAND HISTORY
#--------------------

HISTSIZE=100000
HISTFILESIZE=100000

#--------------------
# PROMPT
#--------------------

PS1="\u@\h \w >> "

#--------------------
# ALIASES
#--------------------

alias f='cd'
alias p='cd ..'
alias h='cd ~'
alias r='cd /'

alias s='sudo'

alias sc='screen -dRR'

alias tm='tmux'
alias tl='tmux ls'
alias ta='tmux attach'
alias tt='tmux attach -t'

# For vim colors inside of putty
alias ptm='TERM=screen-256color-bce tmux -u'
alias pta='TERM=screen-256color-bce tmux attach -u'
alias ptt='TERM=screen-256color-bce tmux attach -u -t'

alias ga='git add -A :/'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gm='git submodule update --init'

#--------------------
# FUNCTIONS
#--------------------

function clone()
    {
    URL="https://github.com/$1/$2.git"
    git clone $URL
    }

function enolc()
    {
    URL="https://github.com/nickspinale/$1.git"
    git clone $URL
    }

# From Emmanuel Rouat's famous bashrc
function extract()
    {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
    }