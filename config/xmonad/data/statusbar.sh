id=$RANDOM
prefix="minibar"

fifo1="${TMPDIR:-/tmp}/$prefix-fifo1-$id"
fifo2="${TMPDIR:-/tmp}/$prefix-fifo2-$id"

trap "rm -rf $fifo1 $fifo2" EXIT SIGINT SIGTERM

mkfifo -m o+w $fifo1
mkfifo -m o+w $fifo2

cmd='
    while read -rs; do
        tput cols
        read -rs y
        echo -n $y > /dev/tty
    done
'
xterm -e sh -c "($cmd) < $fifo1 > $fifo2" &> /dev/null &

cat <&0 > $fifo1 &
cat $fifo2
