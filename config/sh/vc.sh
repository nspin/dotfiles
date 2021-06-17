alias enolc='clone nspin'
alias enolcb='cloneb nickspinale'
alias edulom='module nspin'
alias enolcto='cloneto nspin'

alias g='git'
alias gs='git status'
alias gb='git branch'
alias ga='git add -A :/'
alias gc='git commit'
alias gca='git commit --amend'
alias gcx='git commit -m x'
alias gl='git log'
alias gm='git submodule update --init --recursive'
alias gu='git submodule foreach git pull origin master'
alias gri='git rebase -i'
alias griu='git rebase -i upstream'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gh='git checkout'
alias ghb='git checkout -b'
alias unpushed='git log --branches --not --remotes --no-walk --decorate --oneline'

alias gd='git daemon --verbose --export-all --base-path=.git --reuseaddr --strict-paths .git/'

alias cgl='clone_gitlab'

# Status of git repos in current directory
statuses() {
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

# Pull into git repos in current directory
pulls() {
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

clone() {
    URL="https://nspin@github.com/$1/$2.git"
    git clone $URL
}

cloneto() {
    URL="https://nspin@github.com/$1/$2.git"
    git clone $URL $3
}

cloneb() {
    URL="https://nickspinale@bitbucket.org/$1/$2.git"
    git clone $URL
}

module() {
    URL="https://github.com/$1/$2.git"
    git submodule add $URL $3
}

clone_gitlab() {
    git clone git@gitlab.com:$1/$2.git
}
