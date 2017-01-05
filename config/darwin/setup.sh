plist=$DOTFILES/config/darwin/my.env.plist
ln -s $plist ~/Library/LaunchAgents
launchctl load $plist
