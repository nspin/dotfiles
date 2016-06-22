CONFIGDIR=/home/nick/dotfiles/config
xrdb -merge -I $CONFIGDIR/xresources $CONFIGDIR/xresources/xterm
xmodmap $CONFIGDIR/x11/Xmodmap
xset r rate 300 50
feh --bg-max ~/.background.jpg
# for img in ~./background.{png,jpg}; do
#     feh --bg-max "$img"
# done
# xsetroot -solid '#002B36'
