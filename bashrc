###############################
# NICK SPINALE
# $HOME/.bashrc
###############################

# HACKY WAY TO MAKE COLORS IN SCREEN OK IN X11/OSX
# TODO - make this not suck
export TERM="xterm-256color"

#--------------------
# PROMPT
#--------------------

PS1="\u@\h \w <> "

#--------------------
# ALIASES
#--------------------

alias b='cd ..'
alias h='cd ~'
alias r='cd /'

alias sc='screen -dRR'

alias ga='git add -A'
alias gs='git status'
alias gc='git commit'
alias gph='git push'
alias gpl='git pull'

#--------------------
# PROMPT
#--------------------

PS1="\u@\h \w >> "

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
