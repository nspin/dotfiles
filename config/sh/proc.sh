alias osxterm='open $MY_DOTFILES/config/darwin/solarized.terminal'

function orphan() {
    "$@" &> /dev/null &
}
