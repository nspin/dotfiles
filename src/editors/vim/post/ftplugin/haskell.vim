let s:exts_cmd = 'ghc --show-options | grep -e ^-X | cut -c 3-'
let s:fzf_cmd = 'fzf -m'

" fun s:addprag()
"   silent !clear
"   exe 'silent !'.s:exts_cmd.' | '.'fzf -m > wat'
"   redraw!
"   echo readfile('wat')
" endfun

fun! s:fzf_tmux_exts()
  let y = split(system(s:exts_cmd.' | '.'fzf-tmux -m'))
  call s:add_exts(y)
endfun

fun! s:add_exts(exts)
  if getline(1)[0] != '{'
    call append(0, '')
  endif
  for ext in a:exts
    call append(0, '{-# LANGUAGE '.ext.' #-}')
  endfor
  exe "normal mfgg}k:0,.sort\n`f"
endfun

command! AddExts call <sid>fzf_tmux_exts()
