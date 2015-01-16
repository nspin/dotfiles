#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrdb -merge ~/.Xresources

xset r rate 300 50 &
# xsetroot -cursor_name left_ptr &

# background
# if hash feh 2>/dev/null; then
    # feh --bg-scale $HOME/dotfiles/cetera/glacier.jpg &
# fi

xterm &

xmonad
