pkgs: with pkgs; [

emacs

zathura
libreoffice

haskellPackages.pandoc

vlc

(texlive.combine {
  inherit (texlive)
    scheme-small
    pbox
    csquotes
    beamerposter
    type1cm
  ;
})

]
