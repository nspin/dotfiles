pkgs: with pkgs; [

coreutils

# nix
nix-repl
nix-prefetch-scripts

# misc command line utils
zip
unzip

# random
rlwrap

# x utils
xclip
xorg.xkill
xlibs.xmodmap
xlibs.xmessage
haskellPackages.xmobar
dmenu
gmrun

# x applications
firefox
#xchat

# fonts
dejavu_fonts

# productivity
tmux
git
fzf
local.fzf-tmux

vimHugeX

local.lib.vimRtpOf ( [  ]
    /* ++ map (local.lib.flip builtins.getAttr local.lame-vim-plugins.github) */
    /*        (local.lib.txtToList ../../../vim-config/plugins/github.txt) */
)

]
