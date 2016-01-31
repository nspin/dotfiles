nmap <c-c><c-f> vaF<c-c><c-c>``
nmap <space>v v%<c-c><c-c>

nnoremap <space>p1 :SlimeSend1 "!-1"<cr>

function! WordCount() range
  let lines = join(getline(a:firstline, a:lastline), "\n")
  echo system('echo "'.lines.'" | wc -w')
endfunction

command! -range WC <line1>,<line2>:call WordCount()
