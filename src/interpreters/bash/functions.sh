#--------------------
# FUNCTIONS
#--------------------

function x() {
    $1 &> /dev/null &
}

# Status of git repos in current directory
function statuses()
    {
    currdir=$(pwd)
    for subdir in ./*/ ; do
        cd $subdir
        if [ -e .git ] ; then
            echo ""
            echo "$subdir"
            git status
        fi
        cd $currdir
    done
    echo ""
    }

# Status of git repos in current directory
function pulls() {
    currdir=$(pwd)
    for subdir in ./*/ ; do
        cd $subdir
        if [ -e .git ] ; then
            echo ""
            echo "$subdir"
            git pull
        fi
        cd $currdir
    done
    echo ""
}

function clone() {
    URL="https://github.com/$1/$2.git"
    git clone $URL
}

function enolc() {
    URL="https://github.com/nickspinale/$1.git"
    git clone $URL
}

function module() {
    URL="https://github.com/$1/$2.git"
    git submodule add $URL $3
}

function eludom() {
    URL="https://github.com/nickspinale/$1.git"
    git submodule add $URL $3
}

# From Emmanuel Rouat's bashrc
function extract() {
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
