nmap <c-c><c-f> vaF<c-c><c-c>``
nmap <space>v v%<c-c><c-c>

nnoremap <leader>a :SlimeSend1 !-1<cr>

fun s:word_count() range
  let lines = join(getline(a:firstline, a:lastline), "\n")
  echo system('echo "'.lines.'" | wc -w')
endfun

command! -range WC <line1>,<line2>:call <sid>word_count()

command! CW echo split(system('wc '.expand('%'))[:-2])[1]
