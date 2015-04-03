" TODO make this not lame

set background=dark         " to get correct defaults
highlight clear             " start with a clean slate
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "nicebox"

highlight Normal        cterm=NONE  ctermbg=black       ctermfg=white
highlight ColorColumn   cterm=NONE  ctermbg=darkred     ctermfg=NONE

highlight StatusLineNC  cterm=NONE  ctermbg=darkgrey    ctermfg=grey
highlight TabLine       cterm=NONE  ctermbg=darkgrey    ctermfg=grey

highlight Pmenu         cterm=NONE  ctermbg=darkgrey    ctermfg=red
highlight PmenuSel      cterm=NONE  ctermbg=darkgrey    ctermfg=black

highlight Comment       cterm=NONE  ctermbg=NONE        ctermfg=darkgrey
highlight NonText       cterm=NONE  ctermbg=NONE        ctermfg=darkgrey
highlight LineNr        cterm=NONE  ctermbg=NONE        ctermfg=darkgrey

highlight TabLineSel    cterm=NONE  ctermbg=grey        ctermfg=black

highlight StatusLine    cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight TabLine       cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight TabLineFill   cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight VertSplit     cterm=NONE  ctermbg=darkgrey    ctermfg=black
highlight Title         cterm=NONE  ctermbg=darkgrey    ctermfg=black
