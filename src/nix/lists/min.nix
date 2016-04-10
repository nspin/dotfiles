pkgs: with pkgs; [

openssl

which

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

# fonts
dejavu_fonts

# productivity
tmux
git
mercurial
subversion
fzf

vimHugeX

(vim-rtp "annoying.rtp" [ ycm ])

]
