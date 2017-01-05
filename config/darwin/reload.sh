sh $(dirname $0)/update_plist.sh
plist=$DOTFILES/config/darwin/my.env.plist
launchctl unload $plist
launchctl load $plist
