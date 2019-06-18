#!/bin/sh

amnt=$(upower -i /org/freedesktop/UPower/devices/battery_sbs_9_000b | sed -rn 's/^.*percentage:\s+([^\s]+)/\1/p')

state=$(upower -i /org/freedesktop/UPower/devices/battery_sbs_9_000b | sed -rn 's/^.*state:\s+([^\s]+)/\1/p')

symb=?
case "$state" in
    charging) symb=⬆ ;;
    discharging) symb=⬇ ;;
    fully-charged) symb=⚡;;
esac

printf 'Batt %s %s\n' "$symb" "$amnt"
