let s:exts_cmd = 'ghc --show-options | grep -e ^-X | cut -c 3-'
let s:fzf_cmd = 'fzf -m'

fun s:addprag()
  silent !clear
  exe 'silent !'.s:exts_cmd.' | '.'fzf -m > wat'
  redraw!
  echo readfile('wat')
endfun

fun s:mux()
  let y = split(system(s:exts_cmd.' | '.'fzf-tmux -m'))
  for x in y
    call append(0, '{-# LANGUAGE '.x.' #-}')
  endfor
endfun

command Ext call <sid>addprag()
command Txe call <sid>mux()
