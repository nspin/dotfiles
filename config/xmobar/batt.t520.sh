#!/bin/sh

amnt=$(upower --dump | sed -n '/Device.*BAT/,/^$/p' | sed -nE 's/^.*percentage:\s+([^\s]+)/\1/p')

state=$(upower --dump | sed -n '/Device.*BAT/,/^$/p' | sed -nE 's/^.*state:\s+([^\s]+)/\1/p')

symb=?
case "$state" in
    charging) symb=⬆ ;;
    discharging) symb=⬇ ;;
    fully-charged) symb=⚡;;
esac

printf 'Batt %s %s\n' "$symb" "$amnt"
