alias v=vim
alias vi=vim
alias vf='vim $(fzf)'
alias tod='efd $HOME/todo'
alias dot='efd $MY_DOTFILES'
alias loc='efd $MY_LOCAL'
alias cdd='cd $MY_DOTFILES'
alias cds='cd $HOME/scratch'

alias s=sublime3
alias p=python3

# TODO ack
fzfd() {
    dir=$(echo $1 | sed 's:/$::')
    find $dir -type f \
      | sed 's:^'"$dir"'/::' \
      | grep -v '^\.\|/\.' \
      | fzf-tmux -m \
      | sed 's:^:'"$dir"'/:'
}

efd() {
    files="$(fzfd $1)"
    if [ -n "$files" ]; then
        echo "$files"
        vim $(echo $files | tr '\n' ' ')
    fi
}
