# TODO ack
function fzfd() {
    dir=$(echo $1 | sed 's:/$::')
    find $dir -type f \
      | sed 's:^'$dir'/::' \
      | grep -v '^\.\|/\.' \
      | fzf-tmux -m \
      | sed 's:^:'$dir'/:'
}

function efd() {
    files=$(fzfd $1)
    echo $files
    vim $(echo $files | tr '\n' ' ')
}

alias v='vim'
alias vi='vim'
alias vf='vim $(fzf)'
alias tod='efd $HOME/todo'
alias dot='efd $DOTFILES'
alias cdd='cd $DOTFILES'
