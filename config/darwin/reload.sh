plist=$DOTFILES/config/darwin/my.env.plist
launchctl unload $plist
launchctl load $plist
