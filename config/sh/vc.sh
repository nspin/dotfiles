# Status of git repos in current directory
function statuses() {
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
    URL="https://nspin@github.com/$1/$2.git"
    git clone $URL
}

function cloneto() {
    URL="https://nspin@github.com/$1/$2.git"
    git clone $URL $3
}

function cloneb() {
    URL="https://nickspinale@bitbucket.org/$1/$2.git"
    git clone $URL
}

function module() {
    URL="https://github.com/$1/$2.git"
    git submodule add $URL $3
}

alias enolc='clone nspin'
alias enolcb='cloneb nickspinale'
alias edulom='module nspin'
alias enolcto='cloneto nspin'

alias ga='git add -A :/'
alias gs='git status'
alias gc='git commit'
alias gl='git pull'
alias gm='git submodule update --init'
alias gu='git submodule foreach git pull origin master'
