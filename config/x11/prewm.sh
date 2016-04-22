X11DIR=/home/nick/dotfiles/config/x11
xrdb -merge -I $X11DIR/xresources $X11DIR/xresources/xterm
sh $X11DIR/misc_config.sh
xmodmap $X11DIR/Xmodmap
