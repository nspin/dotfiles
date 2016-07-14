pkgs: with pkgs; [

emacs

(vim-rtp "annoying.rtp" [ ycm ])

(texlive.combine {
  inherit (texlive)
    scheme-small
    collection-latexextra
    collection-fontsrecommended
    # pbox
    # csquotes
    # beamerposter
    # type1cm
  ;
})

apktool
androidsdk
# mitmproxy

]
