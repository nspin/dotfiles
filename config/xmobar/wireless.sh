#!/bin/sh

iwconfig wlp3s0 2>&1 | grep -q 'no wireless extensions' && {
  printf 'Conn: wired'
  exit 0
}

essid=$(iwconfig wlp3s0 | awk -F '"' '/ESSID/ {print $2}')
stngth=$(iwconfig wlp3s0 | awk -F '=' '/Quality/ {print $2}' | cut -d '/' -f 1)

printf 'Conn: %s %s%%\n' "$essid" "$stngth"
