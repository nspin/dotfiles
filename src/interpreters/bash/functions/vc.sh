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
    URL="https://nickspinale@github.com/$1/$2.git"
    git clone $URL
}

function enolc() {
    clone nickspinale $1
}

function cloneb() {
    URL="https://nickspinale@bitbucket.org/$1/$2.git"
    git clone $URL
}

function enolcb() {
    cloneb nickspinale $1
}

function module() {
    URL="https://github.com/$1/$2.git"
    git submodule add $URL $3
}

function eludom() {
    URL="https://github.com/nickspinale/$1.git"
    git submodule add $URL $3
}
