#### Unetbootin Slackware ISO

*   Install from partition
*   `/dev/sdb1`
*   `slackware` (NO LEADING SLASH)

#### Wifi issues

su:

`
dhcpcd eth0

ifconfig wlan0 up
iwlist wlan0 scan (find nw)
iwconfig wlan0 {option value}
dhclient wlan0
`

(or wicd-curses from /extra/)

#### Slackware resolution on vm (semi-) fix

Insert guest addition iso

su:

`
mount /dev/sr0 /mnt/dvd
cd /mnt/dvd
sh ./VBoxLinuxAdditions.run

cp /etc/X11/xorg.conf-vesta /etc/X11/xorg.conf
vim xorg.conf:

(Section "Device")
   #Driver    "(...)"
   Driver    "vboxvideo"

(Section "Screen", at DefaultDepth display)
     Modes = "1366x768":Modes
`
#### Other

`adduser` script

`lilo.conf += append="resume=/dev/sdaX"; lilo` (for pm-hibernate)
