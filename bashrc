###############################
# NICK SPINALE
# $HOME/.bashrc
###############################

# Check if interactive
[ -z "$PS1" ] && reset

#--------------------
# ALIASES
#--------------------

alias b='cd ..'
alias h='cd ~'
alias r='cd /'

alias t='tar -xzvf'

alias a='git add -A'
alias c='git commit'
alias ph='git push'
alias pl='git pull'

#--------------------
# PROMPT
#--------------------

PS1="\u@\h \w <> "

#--------------------
# MISC
#--------------------

function clone
    {
    URL="https://github.com/$1/$2.git"
    git clone $URL
    }

function enolc
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
