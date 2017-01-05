sh $(dirname $0)/update_plist.sh
plist=$DOTFILES/config/darwin/my.env.plist
ln -s $plist ~/Library/LaunchAgents
launchctl load $plist
