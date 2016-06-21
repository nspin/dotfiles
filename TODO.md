# TODO

xmonad:

minibar:
    - external library?
    - use xprop with $WINDOWID, or control sequences (OSC ...)
        + https://specifications.freedesktop.org/wm-spec/1.3/ar01s05.html
        + _NET_WM_STRUT/_NET_WM_STRUT_PARTIAL
        + _NET_WM_WINDOW_TYPE
    - how to make xterm just one line?
        ```
        CSI Ps ; Ps ; Ps t
                  Window manipulation (from dtterm, as well as extensions).
                  These controls may be disabled using the allowWindowOps
                  resource.  Valid values for the first (and any additional
                  parameters) are:
                    Ps = 7  -> Refresh the xterm window.
                    Ps = 8  ;  height ;  width -> Resize the text area to given
                  height and width in characters.  Omitted parameters reuse the
                  current height or width.  Zero parameters use the display's
                  height or width.
        ```

fzf launcher:
    - WM_TRANSIENT_FOR or both MIM and MAX size hints

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
