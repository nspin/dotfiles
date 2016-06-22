id=$RANDOM
prefix="minibar"

fifo1="${TMPDIR:-/tmp}/$prefix-fifo1-$id"
fifo2="${TMPDIR:-/tmp}/$prefix-fifo2-$id"

trap "rm -rf $fifo1 $fifo2" EXIT SIGINT SIGTERM

mkfifo -m o+w $fifo1
mkfifo -m o+w $fifo2

cmd='
    xprop -id $WINDOWID -f _NET_WM_STRUT 32c -set _NET_WM_STRUT 0,0,100,0
    # xprop -id $WINDOWID -f _NET_WM_STRUT_PARTIAL 32c -set _NET_WM_STRUT_PARTIAL 0,0,100,0,0,0,0,0,0,400,0,0
    xprop -id $WINDOWID -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_DOCK
    echo -en "\033[3;0;0t" > /dev/tty
    echo -en "\033[8;1;0t" > /dev/tty
    xprop -id $WINDOWID > /dev/tty
    echo "READY"
    while read -rs y; do
        echo -n $y > /dev/tty
    done
  # while read -rs; do
  #     tput cols
  #     read -rs y
  #     echo -n $y > /dev/tty
  # done
'
xterm -e sh -c "($cmd) < $fifo1 > $fifo2" &> /dev/null &

cat <&0 > $fifo1 &
cat $fifo2
