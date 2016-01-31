function! PlainText()
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
endfunction

function! UnPlainText()
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
endfunction

command! PlainText :call PlainText()
command! UnPlainText :call UnPlainText()
