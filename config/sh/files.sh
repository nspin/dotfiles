# TODO ack
function fzfd() {
    dir=$(echo $1 | sed 's:/$::')
    find $dir -type f \
      | sed 's:^'"$dir"'/::' \
      | grep -v '^\.\|/\.' \
      | fzf-tmux -m \
      | sed 's:^:'"$dir"'/:'
}

function efd() {
    files="$(fzfd $1)"
    if [ -n "$files" ]; then
        echo "$files"
        vim $(echo $files | tr '\n' ' ')
    fi
}

alias v=vim
alias vi=vim
alias vf='vim $(fzf)'
alias tod='efd $HOME/todo'
alias dot='efd $MY_DOTFILES'
alias cdd='cd $MY_DOTFILES'

alias s=sublime3
alias p=python3
