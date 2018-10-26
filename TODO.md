# TODO

bad: ~/.config is itself a symlink

nixos:
    nixpkgs.overlays option for ad hoc, using NIX_PATH="np=$MY_DOTFILES/nix/pkgs/np.nixos.nix"

--------------

tmux:
    xclip binding for vm

stalonetray volume and stuff

.bashrc.local

show volume on volume change

tws
file browser
vim mark stack

--------------

OPTIONS:
    title as hook
    embed in another window
    wait a bit

general:
    take picture after incorrect login:
        http://askubuntu.com/questions/253189/can-i-make-the-webcam-take-a-picture-when-an-incorrect-password-is-entered

xmonad:

minibar:
    - external library?
    - use xprop with $WINDOWID, or control sequences (OSC ...)
        + https://specifications.freedesktop.org/wm-spec/1.3/ar01s05.html
    - how to make xterm just one line?
        + $LINES
    - pass windowid INTO statusline.hs

    --- xterm --into

    --- URXVT: -embed
               -pty-fd
        

fzf launcher:
    - WM_TRANSIENT_FOR or both MIM and MAX size hints

xterm:
    - xterm\*highlightSelction: true

---

*   fzf instead of dmenu
*   middle mouse button

---

*   roll own fzf shell scripts

*   helm emacs
*   two alt keys
*   fn to ctr?
*   menu and windows keys for xmonad?

*   dmenu/gmenu/slim/nodisplaymanager?

*   list dependencies of components
*   make stuff work on cmc builds

*   Xnest setup?
*   Dmenu font
*   setup.sh backup
*   slim down xmonad conf
*   autojump, z, fasd?
