fun s:plain_text()
  setlocal wrap
  setlocal linebreak
  setlocal nonumber
  setlocal norelativenumber
  setlocal foldcolumn=1
  hi FoldColumn ctermbg=8
  noremap j gj
  noremap k gk
  noremap gj j
  noremap gk k
endfun

fun s:un_plain_text()
  setlocal nowrap
  setlocal nolinebreak
  setlocal number
  setlocal relativenumber
  setlocal foldcolumn=0
  hi FoldColumn ctermbg=0
  unmap j
  unmap k
  unmap gj
  unmap gk
endfun

command! PlainText :call <sid>plain_text()
command! UnPlainText :call <sid>un_plain_text()

fun s:plain()
  setlocal wrap
  setlocal linebreak
  noremap j gj
  noremap k gk
  noremap gj j
  noremap gk k
endfun

fun s:un_plain()
  setlocal nowrap
  setlocal nolinebreak
  unmap j
  unmap k
  unmap gj
  unmap gk
endfun

command! Plain :call <sid>plain()
command! UnPlain :call <sid>un_plain()

noremap <space>] :set paste<cr>
noremap <space>[ :set nopaste<cr>
