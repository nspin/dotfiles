function marsf () {
    mars nc $@ | sed -e "s/\t/ /g"
}

function marsl () {
    length=$1
    shift
    marsf 0x10010000-$((0x10010000 + ($length - 1) * 4)) $@
}
