CONFIGDIR=/home/nick/dotfiles/config
xrdb -merge -I $CONFIGDIR/xresources $CONFIGDIR/xresources/xterm
sh $CONFIGDIR/x11/misc_config.sh
xmodmap $CONFIGDIR/x11/Xmodmap
