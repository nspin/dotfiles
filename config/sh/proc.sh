alias osxterm='open $MY_DOTFILES/config/darwin/solarized.terminal'

orphan() {
    "$@" &> /dev/null &
}
