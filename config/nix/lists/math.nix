pkgs: with pkgs; [

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

]